import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // final googleUser = await GoogleSignIn().signIn();
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return cred.user;
    } on FirebaseAuthException catch (e) {
      exceptionHandler(e.code);
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      exceptionHandler(e.code);
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> updateUserProfile(
    String fullName,
    String email,
    String username,
    String password, {
    String? imageUrl,
  }) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Update user profile information in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'fullName': fullName,
          'email': email,
          'username': username,
          if (imageUrl != null) 'imageUrl': imageUrl,
        });

        // Update email with verification
        await user.verifyBeforeUpdateEmail(email);

        // Update password
        await user.updatePassword(password);

        log('User profile updated successfully');
      }
    } catch (e) {
      log('Error updating profile: $e');
    }
  }

  Future<void> updatePassword(String password) async {
    try {
      User? user = _auth.currentUser;
      await user?.updatePassword(password);
    } catch (e) {
      log("Failed to update password: $e");
    }
  }

  Future<void> reauthenticate(String email, String password) async {
    try {
      User? user = _auth.currentUser;
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user?.reauthenticateWithCredential(credential);
    } catch (e) {
      log("Reauthentication failed: $e");
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut(); // Clear Google sign-in session
    } catch (e) {
      log("Something went wrong");
    }
  }
}

exceptionHandler(String code) {
  switch (code) {
    case "invalid-credential":
      print("Your login credentials are invalid");
    case "weak-password":
      print("Your password must be at least 6 Characters");
    case "email-already-in-use":
      print("User already exists");
    default:
      print("Unknown error occured!");
  }
}
