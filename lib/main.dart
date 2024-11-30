// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:n3auth/pages/home_page.dart';
import 'package:n3auth/pages/login_page.dart';
import 'package:n3auth/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Login',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
