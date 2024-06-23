import 'package:bookhavenapp/models/borrowing_model.dart';
import 'package:bookhavenapp/screens/homepage.dart';
import 'package:bookhavenapp/screens/notification.dart';
import 'package:bookhavenapp/services/http_service.dart';
import 'package:flutter/material.dart';

class Borrowing extends StatefulWidget {
  const Borrowing({Key? key}) : super(key: key);

  @override
  State<Borrowing> createState() => _BorrowingState();
}

class _BorrowingState extends State<Borrowing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<BorrowingModel> _borrowings = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // _fetchBorrowings(); // Perbaikan: Panggil method _fetchBorrowings dengan tanda kurung
  }

  // Future<void> _fetchBorrowings() async {
  //   try {
  //     final httpService = HttpService();
  //     final borrowings = await httpService
  //         .fetchBorrowings(); // Perbaikan: Simpan hasil dari fetchBorrowings ke dalam borrowings
  //     setState(() {
  //       _borrowings =
  //           borrowings; // Perbaikan: Simpan data yang diterima ke dalam _borrowings
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _errorMessage = 'Gagal memuat borrowing. Kesalahan: $e';
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Borrowings'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _buildBorrowingsList(),
    );
  }

  Widget _buildBorrowingsList() {
    return ListView.builder(
      itemCount: _borrowings.length,
      itemBuilder: (context, index) {
        BorrowingModel borrowing = _borrowings[index];
        return ListTile(
          title: Text('Book ID: ${borrowing.bookId}'),
          subtitle: Text('Borrowed by User ID: ${borrowing.userId}'),
          // Customize how you want to display other details
        );
      },
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFF55769F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                size: 40, color: Colors.black54),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: IconButton(
                        icon: Icon(Icons.notifications,
                            size: 40, color: Colors.black54),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notifications()));
                        },
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    "Currently Borrowing",
                    style: TextStyle(
                      fontSize: 36,
                      color: Color(0xFF110239),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: borrowedBooks.length,
            itemBuilder: (context, index) {
              final book = borrowedBooks[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            book['image'] ??
                                'assets/default.jpg', // Provide a default image path
                            height: 150,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['title'] ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF110239),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Author: ${book['author'] ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF110239).withOpacity(0.8),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Due Date: ${book['dueDate'] ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF110239).withOpacity(0.6),
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Return book logic
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF110239),
                                  onPrimary: Colors.white,
                                  minimumSize: Size(100, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Color(0xFF110239),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Return Book",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

final borrowedBooks = [
  {
    'title': 'Juan Dara',
    'author': 'Cut Putri Khairan',
    'dueDate': 'June 30, 2024',
    'image': 'assets/JUANDARA.jpg',
  },
  {
    'title': 'Another Book',
    'author': 'Another Author',
    'dueDate': 'July 15, 2024',
    'image': 'assets/JUANDARA.jpg',
  },
  // Add more books here
];
