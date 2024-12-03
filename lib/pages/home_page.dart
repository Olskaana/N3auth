// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Variável que armazena o nome do usuário
  String _userName = ''; 
  //Variável que armazena o email do usuário
  String _userEmail = '';
  //Variável que armazena a foto de perfil do usuário
  String _userPhotoUrl = '';

  @override
  void initState() {
    super.initState();
    //Verifica se o usuário está logado ao iniciar a página
    _checkUserStatus();
  }

  //Função que verifica se o usuário está autenticado
  Future<void> _checkUserStatus() async {
    //Obtém o usuário atual do Firebase
    User? user = _auth.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      //Chama a função para buscar os dados do usuário logado
      _fetchUserData();
    }
  }

  //Função para buscar os dados do usuário, como nome, e-mail e foto de perfil
  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        setState(() {
          _userName = user.displayName ?? user.email?.split('@')[0] ?? 'User';
          _userEmail = user.email ?? 'Email not available';
          _userPhotoUrl = user.photoURL ?? '';
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  //Função para realizar o logout do usuário
  Future<void> _logout() async {
    try {
      await _auth.signOut();
      if (_auth.currentUser == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    //Tratamanto de erro ao tentar sair
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage = 'Error logging out. Please try again later.';
      } else {
        errorMessage = 'Unknown error occurred while logging out.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  //Função para excluir a conta do usuário
  Future<void> _deleteUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        //Exclui a conta
        await user.delete();
        //Força o logout após a exclusão 
        await _auth.signOut(); 

        //Verifica o estado do usuário e redireciona para o login
        User? currentUser = _auth.currentUser;
        if (currentUser == null) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: User still exists after deletion.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found to delete.')),
        );
      }
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        if (e.code == 'requires-recent-login') {
          errorMessage = 'You need to re-authenticate before deleting your account.';
        } else {
          errorMessage = 'Error deleting account. Please try again later.';
        }
      } else {
        errorMessage = 'Unknown error occurred while deleting the account.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  //Função para confirmar a exclusão da conta via um diálogo
  Future<void> _confirmDelete() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete your account?'),
          content: Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUser();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Exibe o nome do usuário na barra de navegação
        title: Text('Welcome, $_userName!'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color(0xFF2D2D2D),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _userPhotoUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 50,
                      //Exibe a foto de perfil se estiver disponível
                      backgroundImage: NetworkImage(_userPhotoUrl),
                    )
                  : FaIcon(
                      FontAwesomeIcons.user,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 90,
                    ),
              SizedBox(height: 20),
              Text(
                'Name: $_userName',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'Email: $_userEmail',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _logout,
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _confirmDelete,
                icon: Icon(Icons.delete_forever),
                label: Text('Delete Account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
