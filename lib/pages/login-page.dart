import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_jogos/pages/cadastro-page.dart';
import 'package:gerenciador_jogos/services/login-service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void abrirCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroPage()),
    );
  }

  login() async {
    try {
      await LoginService.loginUsuario(
        emailController.text,
        senhaController.text,
      );
      if (mounted) {
        showMensagem('Login realizado com sucesso!', error: false);
      }
    } on FirebaseAuthException catch (erro) {
      print(erro.code);
      if (erro.code == 'invalid-credential' ||
          erro.code == 'user-not-found' ||
          erro.code == 'wrong-password') {
        showMensagem('Usuário ou senha inválidos');
      } else if (erro.code == 'invalid-email') {
        showMensagem('E-mail com formato inválido');
      } else if (emailController.text.isEmpty || senhaController.text.isEmpty) {
        showMensagem('Por favor, preencha todos os campos.');
      } else {
        showMensagem('Erro ao fazer login: ${erro.code}');
      }
    }
  }

  showMensagem(String msg, {bool error = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(onPressed: login, child: Text('Login')),
            TextButton(
              onPressed: () {
                abrirCadastro();
              },
              child: Text('Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
