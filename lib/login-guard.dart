import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_jogos/pages/home-page.dart';
import 'package:gerenciador_jogos/pages/login-page.dart';
import 'package:gerenciador_jogos/services/login-service.dart';

class LoginGuard extends StatelessWidget {
  const LoginGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: LoginService.status,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
