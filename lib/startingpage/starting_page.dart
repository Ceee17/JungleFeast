import 'package:flutter/material.dart';
import 'package:uas/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/auth/login_page.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  Future<void> _completeInitialSetup(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Wrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 6, right: 6),
            child: Center(
              child: Text(
                '“The only trip you will regret\nis the one You didn’t take”',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Poppins",
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 17),
            child: Image.asset(
              'assets/startingpage.png',
              height: 120,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 10),
            child: Center(
              child: Text(
                "Are you ready to have fun with us? Let’s trust us and\n"
                "share your dream holiday with us!\n"
                "Welcome to Junglefeast",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Poppins",
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _completeInitialSetup(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFA62F),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text('Get Started!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                )),
          )
        ],
      ),
    );
  }
}
