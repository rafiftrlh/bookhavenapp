import 'package:bookhavenapp/models/book_detail_model.dart';
import 'package:bookhavenapp/providers/user_provider.dart';
import 'package:bookhavenapp/screens/book.dart';
import 'package:bookhavenapp/screens/borrowing.dart';
import 'package:bookhavenapp/screens/homepage.dart';
import 'package:bookhavenapp/screens/rating.dart';
import 'package:bookhavenapp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  final int id;
  const BookDetails({Key? key, required this.id}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final HttpService httpService = HttpService();
  BookDetail? _bookDetail;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchBookDetail(widget.id);
  }

  Future<void> _fetchBookDetail(int id) async {
    try {
      final bookDetail = await httpService.fetchBookDetail(id);
      setState(() {
        _bookDetail = bookDetail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load book details. Error: $e';
        _isLoading = false;
      });
    }
  }

  void _borrowBook() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final int? userId =
          userProvider.user?.id; // Use ?. operator to safely access id

      if (userId == null) {
        throw Exception('User ID is null or user is not logged in.');
      }

      httpService.borrowBook(
        context: context,
        userId: userId,
        bookId: widget.id,
      );
    } catch (e) {
      print('Error during borrowing request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during borrowing request')),
      );
    }
  }

  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  void _handleRating(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  void _submitReview() {
    String reviewText = _reviewController.text;
    int rating = _selectedRating;

    // Handle review submission logic here
    print('Review: $reviewText');
    print('Rating: $rating');

    // Clear the form after submission
    _reviewController.clear();
    setState(() {
      _selectedRating = 0;
    });
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_bookDetail);
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 650,
                        decoration: BoxDecoration(
                          color: Color(0xFF55769F),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.arrow_back,
                                                  size: 40,
                                                  color: Colors.black54),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookKatalog(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: IconButton(
                                          icon: Icon(Icons.notifications,
                                              size: 40, color: Colors.black54),
                                          onPressed: () {
                                            //
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          child: _bookDetail?.coverUrl != null
                                              ? Image.network(
                                                  _bookDetail!.coverUrl!,
                                                  height: 300,
                                                  width: 200,
                                                  fit: BoxFit
                                                      .cover, // Adjust as needed
                                                )
                                              : Image.asset(
                                                  'assets/placeholder_image.jpg', // Provide a placeholder image path
                                                  height: 300,
                                                  width: 200,
                                                  fit: BoxFit
                                                      .cover, // Adjust as needed
                                                ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _bookDetail!.titleBook,
                                              style: TextStyle(
                                                fontSize: 44,
                                                color: Color(0xFF110239),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Authors:",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color(0xFF110239),
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                  ...?_bookDetail?.authors
                                                      .map((author) => Text(
                                                            author.name,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Color(
                                                                  0xFF110239),
                                                            ),
                                                          ))
                                                      .toList(),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 15),
                                              child: Text(
                                                "Published on January 2021",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xFF110239)
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, top: 10),
                                              child: Row(
                                                children: [
                                                  ...?_bookDetail?.categories
                                                      .map(
                                                        (category) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        6),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFF110239),
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              category.name,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xFF110239),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${_bookDetail?.total_rating.toStringAsFixed(1)}/5.0",
                                            style: TextStyle(
                                              fontSize: 27,
                                              color: Color(0xFF110239),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Rating",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xFF110239)
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 60),
                                      Column(
                                        children: [
                                          Text(
                                            "1.2 MB",
                                            style: TextStyle(
                                              fontSize: 27,
                                              color: Color(0xFF110239),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "File Size",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xFF110239)
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 60),
                                      Column(
                                        children: [
                                          Text(
                                            "250",
                                            style: TextStyle(
                                              fontSize: 27,
                                              color: Color(0xFF110239),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Pages",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xFF110239)
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 60),
                                      Column(
                                        children: [
                                          Text(
                                            "1.5K",
                                            style: TextStyle(
                                              fontSize: 27,
                                              color: Color(0xFF110239),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Downloads",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xFF110239)
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                            color: Color(0xFF110239),
                                            width: 2,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            //
                                          },
                                          icon: Icon(
                                              Icons.bookmark_border_outlined),
                                          iconSize: 50,
                                          color: Color(0xFF110239),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: _borrowBook,
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF110239),
                                          onPrimary: Colors.white,
                                          minimumSize: Size(370, 60),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                              color: Color(0xFF110239),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            "Borrow & Read",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "About Book",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF110239),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _bookDetail!.synopsis,
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFF110239),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        padding: EdgeInsets.all(30),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ratings & Reviews",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF110239),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward,
                                      color: Color(0xFF110239), size: 35),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Ratings()));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${_bookDetail?.total_rating.toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Color(0xFF110239),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          index < 4
                                              ? Icons.star
                                              : Icons.star_half,
                                          size: 30,
                                          color: Color(0xFFFFD700),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TRatingProgressIndicator(
                                        text: "5",
                                        value: 1.0,
                                      ),
                                      TRatingProgressIndicator(
                                        text: "4",
                                        value: 0.8,
                                      ),
                                      TRatingProgressIndicator(
                                        text: "3",
                                        value: 0.6,
                                      ),
                                      TRatingProgressIndicator(
                                        text: "2",
                                        value: 0.4,
                                      ),
                                      TRatingProgressIndicator(
                                        text: "1",
                                        value: 0.2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // New review and rating form
                            Text(
                              "Submit Your Review",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF110239),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _reviewController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Your Review',
                              ),
                              maxLines: 5,
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Your Rating: ",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF110239),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Row(
                                  children: List.generate(5, (index) {
                                    return IconButton(
                                      icon: Icon(
                                        index < _selectedRating
                                            ? Icons.star
                                            : Icons.star_border,
                                      ),
                                      color: Color(0xFFFFD700),
                                      iconSize: 30,
                                      onPressed: () => _handleRating(index + 1),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _submitReview,
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF110239),
                                onPrimary: Colors.white,
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Submit Review",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class TRatingProgressIndicator extends StatelessWidget {
  final String text;
  final double value;

  const TRatingProgressIndicator({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF110239),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Color(0xFF55769F),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF110239)),
          ),
        ),
      ],
    );
  }
}
