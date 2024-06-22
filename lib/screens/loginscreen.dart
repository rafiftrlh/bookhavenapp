// login_screen.dart
import 'package:flutter/material.dart';
import 'package:bookhavenapp/screens/registerscreen.dart';
import 'package:bookhavenapp/screens/forgotpw.dart';
import 'package:bookhavenapp/widgets/loginform.dart';
import 'package:bookhavenapp/widgets/navbar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TopNavBar(
              menuItems: ['Sign Up', 'Sign In'],
              onItemSelected: (index) {},
            ),
            SizedBox(height: 70),
            Text(
              "Welcome Back",
              style: TextStyle(
                color: Color(0xFF1F5497),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Sign in with your credentials below.",
              style: TextStyle(
                color: Color(0xFF55769F),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  "New to this app?",
                  style: TextStyle(
                    color: Color(0xFF55769F),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF164b8c),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            LoginForm(),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: Color(0xFF55769F),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ForgotPassword(),
                      ),
                    );
                  },
                  child: Text(
                    'Reset your password here',
                    style: TextStyle(
                      color: Color(0xFF164b8c),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
