import 'package:bookhavenapp/providers/user_provider.dart';
import 'package:bookhavenapp/screens/homepage.dart';
import 'package:bookhavenapp/screens/notification.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'John Doe'; // Nama awal
  String _location = 'New York, USA'; // Lokasi awal
  String _email = 'john.doe@example.com'; // Email awal
  String _phone = '+1 123 456 7890'; // Nomor telepon awal

  void _changeName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = ''; // Untuk menyimpan nama baru
        return AlertDialog(
          title: Text('Change Name'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter your new name'),
            onChanged: (value) {
              newName = value; // Menyimpan nilai input nama baru
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _name = newName; // Mengubah nama dengan nilai baru
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _changeLocation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newLocation = ''; // Untuk menyimpan lokasi baru
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _location = newLocation; // Mengubah lokasi dengan nilai baru
                });
                Navigator.of(context).pop();
              },
              child: Text('cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }

  void _changeEmail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEmail = ''; // Untuk menyimpan email baru
        return AlertDialog(
          title: Text('Change Email'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter your new email'),
            onChanged: (value) {
              newEmail = value; // Menyimpan nilai input email baru
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _email = newEmail; // Mengubah email dengan nilai baru
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _changePhone() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newPhone = ''; // Untuk menyimpan nomor telepon baru
        return AlertDialog(
          title: Text('Change Phone Number'),
          content: TextField(
            decoration:
                InputDecoration(hintText: 'Enter your new phone number'),
            onChanged: (value) {
              newPhone = value; // Menyimpan nilai input nomor telepon baru
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _phone = newPhone; // Mengubah nomor telepon dengan nilai baru
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _location = "Lat: ${position.latitude}, Long: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final username = userProvider.user?.username ?? 'Guest';
    final email = userProvider.user?.email ?? 'guest@gmail.com';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(
                    height: 50,
                  ),
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
                      "Profile",
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
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 5),
                Text(_location),
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed:
                        _changeLocation // Panggil fungsi untuk mengubah email
                    ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                SizedBox(width: 5),
                Text(email),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed:
                      _changeEmail, // Panggil fungsi untuk mengubah email
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone),
                SizedBox(width: 5),
                Text(_phone),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed:
                      _changePhone, // Panggil fungsi untuk mengubah nomor telepon
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _changeName, // Panggil fungsi untuk mengubah nama
              child: Text('Change Name'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  _getCurrentLocation, // Panggil fungsi untuk mendapatkan lokasi saat ini
              child: Text('Get Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}
