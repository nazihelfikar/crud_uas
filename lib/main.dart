import 'package:flutter/material.dart';
import 'pages/anggota/list.dart';
import 'pages/auth/login_form.dart';
import 'pages/auth/register_form.dart';
import 'pages/home.dart';
import 'pages/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyOrmawa - Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // Switch
      ),

      initialRoute: '/', // Halaman pertama kali yang dibuka

      // Daftar route aplikasi
      routes: {
        '/': (context)              => LoginForm(),
        '/register': (context)      => RegisterForm(),
        '/home': (context)          => HomePage(),
        '/anggota/list': (context)  => AnggotaListPage(),
        '/about' : (context)        => AboutPage(),
        '/anggota/add': (context)   => AnggotaAddPage(),
      },
    );
  }
}
