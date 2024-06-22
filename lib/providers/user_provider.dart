import 'package:flutter/material.dart';
import 'package:bookhavenapp/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _accessToken;
  String? _tokenType;

  User? get user => _user;
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  void setTokenType(String tokenType) {
    _tokenType = tokenType;
    notifyListeners();
  }

  void updateUserFromJson(Map<String, dynamic> json) {
    setUser(User.fromJson(json['user']));
    setAccessToken(json['access_token']);
    setTokenType(json['token_type']);
  }
}
