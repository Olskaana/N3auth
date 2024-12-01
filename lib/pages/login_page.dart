// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<User?> _signInWithGitHub() async {
    try {
      final OAuthProvider githubProvider = OAuthProvider('github.com');
      final UserCredential userCredential = await _auth.signInWithPopup(githubProvider);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Unknown error';
      if (e.code == 'account-exists-with-different-credential') {
        errorMessage = 'An account already exists with this email. Try another method.';
      } else if (e.code == 'auth/cancelled-popup-request') {
        errorMessage = 'Authentication canceled.';
      } else {
        errorMessage = 'Error logging in with GitHub: ${e.message}';
      }
      print("Error logging in with GitHub: $errorMessage");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      return null;
    } catch (e) {
      print("Unknown error during GitHub login: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unknown error trying to log in with GitHub")));
      return null;
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email or password cannot be empty")),
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Unknown error';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User not found. Please check the email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many login attempts. Please try again later.';
          break;
        case 'invalid-email':
          errorMessage = 'The email provided is invalid.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The email is already in use. Please log in.';
          break;
        default:
          errorMessage = 'Error logging in: ${e.message}';
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      print("Unknown error during email and password login: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unknown error trying to log in with email")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                User? user = await _signInWithGitHub();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("GitHub login failed")),
                  );
                }
              },
              icon: Icon(Icons.code),
              label: Text('Login with GitHub'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
