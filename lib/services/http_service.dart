import 'dart:convert';
import 'package:bookhavenapp/models/author_model.dart';
import 'package:bookhavenapp/models/book_detail_model.dart';
import 'package:bookhavenapp/models/book_model.dart';
import 'package:bookhavenapp/models/borrowing_model.dart';
import 'package:bookhavenapp/models/category_model.dart';
import 'package:bookhavenapp/models/notifications_model.dart';
import 'package:bookhavenapp/models/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:bookhavenapp/providers/user_provider.dart';
import 'package:bookhavenapp/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  static const String baseUrl = 'http://localhost:8000'; // Ganti dengan base URL API Anda

  Future<void> login({
    required BuildContext context,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    bool? rememberMe,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': usernameController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('user') && data['user'] != null) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.updateUserFromJson(data);

          // Save rememberMe status if selected
          if (rememberMe ?? false) {
            _saveRememberMe(usernameController.text);
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data not found in response')),
          );
        }
      } else if (response.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: Unauthorized role')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Login failed with status code ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during login')),
      );
    }
  }

  Future<void> _saveRememberMe(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', true);
    prefs.setString('username', username);
  }

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/books'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> bookJson = data['books'];
        return bookJson.map((json) => Book.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load books. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load books. Error: $e');
    }
  }

  Future<List<BookDetail>> fetchBookDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/books/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> bookDetailJson = data['books'];
        return bookDetailJson.map((json) => BookDetail.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load book details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load book details. Error: $e');
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/categories'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> categoriesJson = data['categories'];
        return categoriesJson
            .map((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories. Error: $e');
    }
  }

  Future<List<Author>> fetchAuthors() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/authors'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> authorJson = data['authors'];
        return authorJson.map((json) => Author.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load authors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load authors. Error: $e');
    }
  }

  Future<List<RatingBookModel>> fetchRatings() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/rating'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RatingBookModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load ratings. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load ratings. Error: $e');
    }
  }

  Future<List<NotificationModel>> fetchNotifications(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/notification/$id'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notifications. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load notifications. Error: $e');
    }
  }

  Future<List<BorrowingModel>> fetchBorrowings() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/borrowings'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BorrowingModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load borrowings. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load borrowings. Error: $e');
    }
  }
}
