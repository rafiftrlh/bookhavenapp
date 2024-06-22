import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bookhavenapp/widgets/side_menu_tile.dart';
import 'package:bookhavenapp/providers/user_provider.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final username = userProvider.user?.username ??
        'Guest'; // Tampilkan "Guest" jika username null
    return Drawer(
      child: Container(
        width: 288,
        height: double.infinity,
        color: Color.fromARGB(255, 26, 36, 49),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              InfoCard(name: username),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 32, bottom: 16),
                child: Center(
                  child: Text(
                    "Browse".toUpperCase(),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SideMenuTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
          size: 40,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
