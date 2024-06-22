import 'package:bookhavenapp/screens/homepage.dart';
import 'package:bookhavenapp/screens/loginscreen.dart';
import 'package:bookhavenapp/widgets/registerform.dart';
import 'package:flutter/material.dart';
import 'package:bookhavenapp/widgets/navbar.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            TopNavBar(
              menuItems: ['Sign Up', 'Sign In'],
              onItemSelected: (index) {
                // Handle navigation based on index
              },
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              "Welcome Back",
              style: TextStyle(
                color: Color(0xFF1F5497),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Create a new account by filling the forms below.",
              style: TextStyle(
                  color: Color(0xFF55769F),
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  "Have an account?",
                  style: TextStyle(
                      color: Color(0xFF55769F),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Login',
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
            RegisterForm(),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF4683CE),
                    Color(0xFF234268),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
