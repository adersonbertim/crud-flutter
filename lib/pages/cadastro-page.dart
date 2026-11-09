import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_jogos/services/login-service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  cadastrarNovoUsuario() async {
    if (emailController.text.isEmpty || senhaController.text.isEmpty) {
      showMensagem('Por favor, preencha todos os campos.');
      return;
    }
    try {
      await LoginService.criarNovoUsuario(
        emailController.text,
        senhaController.text,
      );
      if (mounted) {
        showMensagem('Usuário cadastrado com sucesso!', error: false);
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMensagem('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        showMensagem('O e-mail fornecido já está em uso.');
      } else {
        showMensagem('Erro ao cadastrar usuário: ${e.message}');
      }
    } catch (e) {
      showMensagem('Erro ao cadastrar usuário: $e');
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
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(label: Text('E-mail:')),
            ),
            SizedBox(height: 10),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(label: Text('Senha:')),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: cadastrarNovoUsuario,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
