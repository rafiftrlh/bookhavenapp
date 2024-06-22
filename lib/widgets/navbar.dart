import 'package:flutter/material.dart';

class TopNavBar extends StatefulWidget {
  final List<String> menuItems;
  final Function(int) onItemSelected;

  TopNavBar({
    required this.menuItems,
    required this.onItemSelected,
  });

  @override
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Book Haven",
            style: TextStyle(
              color: Color(0xFF110239),
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.menu, color: Colors.grey, size: 40,),
            onSelected: (String selectedItem) {
              setState(() {
                _selectedItem = selectedItem;
              });
              int index = widget.menuItems.indexOf(selectedItem);
              widget.onItemSelected(index);
            },
            itemBuilder: (BuildContext context) {
              return widget.menuItems.map((String item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
