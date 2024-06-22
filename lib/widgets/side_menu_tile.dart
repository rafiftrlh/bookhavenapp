import 'package:bookhavenapp/screens/book.dart';
import 'package:bookhavenapp/screens/borrowing.dart';
import 'package:bookhavenapp/screens/favorites.dart';
import 'package:bookhavenapp/screens/history.dart';
import 'package:bookhavenapp/screens/homepage.dart';
import 'package:bookhavenapp/screens/loginscreen.dart';
import 'package:bookhavenapp/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenuTile extends StatefulWidget {
  const SideMenuTile({super.key});

  @override
  _SideMenuTileState createState() => _SideMenuTileState();
}

class _SideMenuTileState extends State<SideMenuTile> {
  String _selectedMenuItem = "Home";

  void _onItemTapped(String itemName) {
    setState(() {
      _selectedMenuItem = itemName;
    });
    switch (itemName) {
      case "Home":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case "Borrowing":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Borrowing()),
        );
        break;
      case "Catalog":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookKatalog()),
        );
        break;
      case "Profile":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      case "History":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => history()),
        );
      case "Favorites":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Favorites()),
        );
        break;
      case "Log Out":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        SizedBox(height: 20),
        _buildMenuItem(
          icon: Icons.home_outlined,
          title: "Home",
        ),
        SizedBox(height: 20),
        _buildMenuItem(
          icon: Icons.book_outlined,
          title: "Borrowing",
        ),
        SizedBox(height: 20),
        _buildMenuItem(
          icon: Icons.library_books_outlined,
          title: "Catalog",
        ),
        SizedBox(height: 20),
        _buildMenuItem(
          icon: CupertinoIcons.person_crop_circle,
          title: "Profile",
        ),
        SizedBox(height: 20),
        _buildMenuItem(
          icon: Icons.history_outlined,
          title: "History",
        ),
        SizedBox(height: 20),
        _buildMenuItem(
          icon: Icons.bookmark,
          title: "Favorites",
        ),
        SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        SizedBox(height: 20),
        _buildMenuItem(
          icon: Icons.logout,
          title: "Log Out",
        ),
      ],
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title}) {
    final isSelected = _selectedMenuItem == title;
    return GestureDetector(
      onTap: () => _onItemTapped(title),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: SizedBox(
            height: 40,
            width: 34,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
