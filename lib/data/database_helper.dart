import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchDataScreen extends StatefulWidget {
  @override
  _FetchDataScreenState createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  String _data = '';

  Future<void> fetchData() async {
    // Replace 'your-machine-ip' with the actual IP address o f your development machine
    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/borrowings'));

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        setState(() {
          _data = responseBody;
        });
      } else {
        setState(() {
          _data = response.reasonPhrase ?? 'Error fetching data';
        });
      }
    } catch (e) {
      setState(() {
        _data = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            Text(
              _data,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
