import 'package:flutter/material.dart';
import 'package:bookhavenapp/screens/homepage.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // Mengubah posisi bayangan
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Book Haven',
              style: TextStyle(
                color: Color.fromRGBO(85, 118, 159, 1),
              ),
            ),
            automaticallyImplyLeading: false,
        
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
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 241, 241, 241),
                  thickness: 2,
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'signin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 241, 241, 241),
                  thickness: 2,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Text("Your content goes here"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 80, // Sesuaikan nilai ini sesuai kebutuhan
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Color.fromRGBO(85, 118, 159, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 250, // Sesuaikan lebar sesuai kebutuhan
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20), // Radius border melingkar
                    border: Border.all(
                      color: Colors.grey, // Warna border
                      width: 1.0, // Lebar border
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your username here',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20), // Sesuaikan padding sesuai kebutuhan
                      border: InputBorder.none, // Menghapus border default
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 250, // Sesuaikan lebar sesuai kebutuhan
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20), // Radius border melingkar
                    border: Border.all(
                      color: Colors.grey, // Warna border
                      width: 1.0, // Lebar border
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email here',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20), // Sesuaikan padding sesuai kebutuhan
                      border: InputBorder.none, // Menghapus border default
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(85, 118, 159, 1),
                    ), // Ganti warna sesuai yang Anda inginkan
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
