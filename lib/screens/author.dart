import 'package:bookhavenapp/models/author_model.dart';
import 'package:bookhavenapp/services/http_service.dart';
import 'package:flutter/material.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  final HttpService httpService = HttpService();
  List<Author> _authors = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAuthors();
  }

  Future<void> _fetchAuthors() async {
    try {
      final authors = await httpService.fetchAuthors();
      setState(() {
        _authors = authors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load authors. Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Authors'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : ListView.builder(
                  itemCount: _authors.length,
                  itemBuilder: (context, index) {
                    final author = _authors[index];
                    return ListTile(
                      title: Text(author.name),
                      // Customize ListTile based on your needs
                    );
                  },
                ),
    );
  }
}
