import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookhavenapp/services/http_service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isObscure = true;
  final HttpService _httpService = HttpService();

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _usernameController.text = prefs.getString('username') ?? '';
      }
    });
  }

  Future<void> _saveRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setBool('rememberMe', true);
      prefs.setString('username', _usernameController.text);
    } else {
      prefs.remove('rememberMe');
      prefs.remove('username');
    }
  }

  void _login() {
    _httpService.login(
      context: context,
      usernameController: _usernameController,
      passwordController: _passwordController,
      rememberMe: _rememberMe,
    );
    _saveRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Username', 'Enter your username', 20.0, false),
        buildInputForm('Password', 'Enter your password', 18.0, true),
        buildRememberMeCheckbox(),
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
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
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
            controller: pass ? _passwordController : _usernameController,
            obscureText: pass ? _isObscure : false,
            decoration: InputDecoration(
              hintText: hint,
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
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility),
                    )
                  : null,
            ),
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
