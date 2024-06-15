
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_near_by/screens/home_page.dart';
import 'package:hospital_near_by/services/google_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  void _showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Unable to login'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToHomePage(BuildContext context, User user) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.googleDark,
              text: 'Sign up with Google',
              onPressed: () async {
                try {
                  User? user = await FirebaseServices().signInWithGoogle();
                  if (user != null) {
                    _navigateToHomePage(context, user);
                  } else {
                    _showLoginErrorDialog(context);
                  }
                } catch (e) {
                  _showLoginErrorDialog(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

