// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo! Faça login para continuar.'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/home', arguments: 'Usuário GitHub');
              },
              icon: Icon(Icons.login),
              label: Text('Login com GitHub'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Registrar-se'),
            ),
          ],
        ),
      ),
    );
  }
}
