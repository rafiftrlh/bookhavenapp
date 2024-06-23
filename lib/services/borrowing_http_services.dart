// import 'dart:convert';
// import 'package:bookhavenapp/models/borrowing_model.dart';
// import 'package:http/http.dart' as http;


// class BorrowingService {
//   final String baseUrl = ''; // Ganti dengan URL API yang sesuai

//   Future<List<Borrowing>> fetchBorrowings() async {
//     final response = await http.get(Uri.parse('$baseUrl/borrowings'));

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => Borrowing.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load borrowings');
//     }
//   }

//   Future<Borrowing> fetchBorrowingById(int id) async {
//     final response = await http.get(Uri.parse('$baseUrl/borrowings/$id'));

//     if (response.statusCode == 200) {
//       return Borrowing.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load borrowing');
//     }
//   }

//   Future<Borrowing> createBorrowing(Borrowing borrowing) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/borrowings'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(borrowing.toJson()),
//     );

//     if (response.statusCode == 201) {
//       return Borrowing.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to create borrowing');
//     }
//   }

//   Future<Borrowing> updateBorrowing(int id, Borrowing borrowing) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/borrowings/$id'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(borrowing.toJson()),
//     );

//     if (response.statusCode == 200) {
//       return Borrowing.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to update borrowing');
//     }
//   }

//   Future<void> deleteBorrowing(int id) async {
//     final response = await http.delete(
//       Uri.parse('$baseUrl/borrowings/$id'),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete borrowing');
//     }
//   }
// }
