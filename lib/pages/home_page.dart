// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text(
          'Bem-vindo, $userName!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
