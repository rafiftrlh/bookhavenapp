import 'package:bookhavenapp/models/book_model.dart';
import 'package:bookhavenapp/models/category_model.dart';
import 'package:bookhavenapp/screens/review.dart';
import 'package:bookhavenapp/services/http_service.dart';
import 'package:flutter/material.dart';

import 'package:bookhavenapp/screens/homepage.dart';
import 'package:bookhavenapp/widgets/sidebar.dart';

class BookKatalog extends StatefulWidget {
  const BookKatalog({Key? key}) : super(key: key);

  @override
  _BookKatalogState createState() => _BookKatalogState();
}

  class _BookKatalogState extends State<BookKatalog> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    List<Book> _books = [];
    bool _isLoading = true;
    String _errorMessage = '';

    @override
    void initState() {
      super.initState();
      _fetchBooks();
    }

    Future<void> _fetchBooks() async {
      try {
        final httpService = HttpService();
        final books = await httpService.fetchBooks();
        setState(() {
          _books = books;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to load books. Error: $e';
          _isLoading = false;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 236, 235, 235),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notification_add_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: SideBar(),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      CategoryListWidget(),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: _books.length,
                          itemBuilder: (context, index) {
                            final book = _books[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookDetails(id: book.id)),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          book.coverUrl ??
                                              'https://via.placeholder.com/150',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.broken_image,
                                                size: 80);
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        book.titleBook,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
    );
  }
}

class CategoryListWidget extends StatefulWidget {
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final httpService = HttpService(); // Instantiate HttpService
      final categories =
          await httpService.fetchCategories(); // Fetch categories
      setState(() {
        _categories = categories; // Update _categories with fetched data
      });
    } catch (e) {
      print('Failed to load categories: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Padding(
            padding: const EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                // Implement navigation or action when a category is tapped
                // Example navigation:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => KategoriScreen(categoryId: category.id)),
                // );
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(85, 118, 159, 1),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
