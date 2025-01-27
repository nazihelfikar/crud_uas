import 'package:flutter/material.dart';
import 'partials/sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String greeting;

  bool isDarkModeEnabled = false;

  _HomePageState() : greeting = _getGreeting();

  static String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Selamat pagi';
    } else if (hour < 15) {
      return 'Selamat siang';
    } else if (hour < 18) {
      return 'Selamat sore';
    } else {
      return 'Selamat malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyOrmawa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue, // Mengganti warna app bar menjadi biru
        actions: [
          IconButton(
            icon: Icon(isDarkModeEnabled ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                isDarkModeEnabled = !isDarkModeEnabled;
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade50], // Mengganti warna gradient menjadi biru
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade300, // Mengganti warna background avatar menjadi biru
                child: Icon(
                  Icons.group,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                greeting,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800, // Mengganti warna teks greeting menjadi biru
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Selamat datang di aplikasi MyOrmawa, aplikasi ini dibuat untuk mengelola data anggota Organisasi Mahasiswa.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Sidebar(),
    );
  }
}
