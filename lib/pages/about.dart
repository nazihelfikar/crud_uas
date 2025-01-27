import 'package:flutter/material.dart';
import 'partials/sidebar.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade800, // Warna biru yang lebih dalam untuk app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade100], // Gradasi biru yang lebih lembut dan elegan
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0), // Menambah padding untuk ruang yang lebih lega
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              // Ikon dengan bayangan untuk kesan elegan
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade300.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 100,
                  color: Colors.blue.shade800, // Ikon biru tua agar kontras dengan latar belakang
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Tentang Aplikasi',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900, // Warna teks judul lebih gelap agar kontras
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Aplikasi ini dibuat untuk sistem manajemen keanggotaan organisasi mahasiswa. '
                'Dengan aplikasi ini, pengelolaan data anggota ormawa menjadi lebih mudah dan terstruktur.',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 0, 0, 0), // Teks deskripsi lebih gelap agar mudah dibaca
                  height: 1.6, // Menambah jarak antar baris
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      drawer: Sidebar(),
    );
  }
}
