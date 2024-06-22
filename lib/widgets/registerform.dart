import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _rememberMe = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Username', 'Username', 20.0, false),
        buildInputForm('Email', 'Admin@gmail.com', 20.0, false),
        buildInputForm('Password', 'Enter your password', 18.0, true),
        buildRememberMeCheckbox(),
      ],
    );
  }

  Padding buildInputForm(
      String label, String hint, double fontSize, bool pass) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF110239),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextFormField(
            obscureText: pass ? _isObscure : false,
            decoration: InputDecoration(
                hintText: hint, // Placeholder text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: pass
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(_isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )
                    : null),
          ),
        ],
      ),
    );
  }

  Padding buildRememberMeCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value!;
              });
            },
          ),
          Text(
            'Remember Me',
            style: TextStyle(fontSize: 20, color: Color(0xFF110239)),
          ),
        ],
      ),
    );
  }
}
