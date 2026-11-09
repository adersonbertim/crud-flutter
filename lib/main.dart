import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gerenciador_jogos/firebase_options.dart';
import 'package:gerenciador_jogos/login-guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Gerenciador de Jogos')),
        body: LoginGuard(),
      ),
    ),
  );
}
