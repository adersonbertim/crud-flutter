import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  static Future<UserCredential> criarNovoUsuario(
    String email,
    String senha,
  ) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
  }

  static Future<UserCredential> loginUsuario(String email, String senha) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );
  }

  static Future<void> logoutUsuario() async {
    await FirebaseAuth.instance.signOut();
  }

  static User? get usuarioLogado => FirebaseAuth.instance.currentUser;

  static Stream<User?> get status => FirebaseAuth.instance.authStateChanges();
}
