import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/accountpage/edit_profile_page.dart';
import 'package:uas/auth/auth_service.dart';
import 'package:uas/design/design.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/dialog.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthService _auth = AuthService();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: appBar,
          ),
        ),
        body: Center(
          child: Text('No user is signed in.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 200,
            height: 200,
            child: Image.asset(
              'assets/junglefeast.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        leadingWidth: 80,
        title: Text(
          'Profile',
          style: appBar,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          Map<String, dynamic>? userData;
          if (snapshot.data != null && snapshot.data!.exists) {
            userData = snapshot.data!.data() as Map<String, dynamic>;
          }

          String? avatarUrl = userData?['avatarUrl'];
          String? displayImageUrl = user?.photoURL ?? userData?['imageUrl'];

          return Center(
            child: Column(
              children: [
                h(20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: displayImageUrl != null
                      ? NetworkImage(displayImageUrl)
                      : AssetImage(avatarUrl!) as ImageProvider<Object>?,
                ),
                h(10),
                Text(
                  userData?['username'] ??
                      user?.displayName ??
                      'No display name',
                  style: headerText(24),
                ),
                Text(
                  userData?['email'] ?? user?.email ?? 'No email',
                  style: customText(
                    16,
                    FontWeight.normal,
                    grey600,
                  ),
                ),
                h(40),
                Card(
                  elevation: 6.0,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Edit Profile'),
                        onTap: user?.photoURL == null
                            ? () {
                                _navigateToEditProfilePage(context, avatarUrl!);
                              }
                            : null,
                        enabled: user?.photoURL == null ? true : false,
                      ),
                      Divider(),
                      ListTile(
                        title: Text('About Us'),
                        onTap: () {
                          navigateToAboutUsPage(context);
                        },
                      ),
                      // Divider(),
                      // ListTile(
                      //   title: Text(
                      //     'Delete My Account',
                      //     style: TextStyle(color: red),
                      //   ),
                      //   onTap: () {
                      //     // Navigate to Settings screen
                      //   },
                      //   enabled: false,
                      // ),
                      Divider(),
                      ListTile(
                        title: Text(
                          'Log Out',
                          style: TextStyle(color: primaryColor),
                        ),
                        onTap: () async {
                          await _auth.signout();
                          navigateToLoginPage(context);
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          'Delete My Account',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () async {
                          if (user == null) {
                            print("No user is signed in.");
                            return;
                          }

                          if (user?.providerData.any((provider) =>
                                  provider.providerId == 'google.com') ??
                              false) {
                            // Show confirmation dialog
                            final confirmed =
                                await showConfirmationDialog(context);
                            if (confirmed ?? false) {
                              // Reauthenticate with Google
                              try {
                                await _auth.reauthenticateWithGoogle();
                                await _auth.deleteAccount();
                                navigateToLoginPage(context);
                              } catch (e) {
                                print(
                                    'Reauthentication with Google failed: $e');
                              }
                            }
                          } else {
                            // Show dialog for email and password input
                            final credentials =
                                await showReauthenticateDialog(context);
                            if (credentials != null) {
                              final email = credentials['email']!;
                              final password = credentials['password']!;

                              try {
                                await _auth.reauthenticate(email, password);
                                await _auth.deleteAccount();
                                // Optionally, navigate the user to the login screen or display a message
                              } catch (e) {
                                print('Reauthentication failed: $e');
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToEditProfilePage(BuildContext context, String avatarUrls) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProfilePage(
                avatarUrl: avatarUrls,
              )),
    ).then((value) {
      setState(() {});
    });
  }
}
