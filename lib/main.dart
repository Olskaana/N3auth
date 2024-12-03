// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:n3auth/pages/home_page.dart';
import 'package:n3auth/pages/login_page.dart';
import 'package:n3auth/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

Future<void> main() async {

  //Garante que o flutter esteja pronto antes de inicializar o Firebase
  WidgetsFlutterBinding.ensureInitialized();

  //Inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Configura a persistência da sessão para manter o usuário logado enquanto o app está ativo
  await FirebaseAuth.instance.setPersistence(Persistence.SESSION);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authenticator',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
