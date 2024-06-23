import 'package:bookhavenapp/models/notifications_model.dart';
import 'package:bookhavenapp/providers/user_provider.dart';
import 'package:bookhavenapp/screens/homepage.dart';
import 'package:bookhavenapp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      final httpService = HttpService();
      final notifications = await httpService.fetchNotifications(1);
      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat notifications. Kesalahan: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final userProvider = Provider.of<UserProvider>(context); // Ambil instance UserProvider dari context
    final username = userProvider.user?.id ?? null; // Dapatkan id pengguna jika tersedia

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), 
            );
          },
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  hintText: 'Search Notifications',
                  hintStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  contentPadding: EdgeInsets.all(20.0),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  isThreeLine: true,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "assets/images/1.png",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text(
                    'New Chapter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
