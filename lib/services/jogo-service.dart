import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerenciador_jogos/models/jogo.dart';
import 'package:gerenciador_jogos/services/login-service.dart';

class JogoService {
  static CollectionReference<Map<String, dynamic>> get _jogos {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .doc(LoginService.usuarioLogado!.uid)
        .collection('jogos');
  }

  static Stream<List<Jogo>> listarJogos() {
    return _jogos
        .orderBy('nome')
        .snapshots()
        .map((dados) => dados.docs.map((jgs) => Jogo.fromDoc(jgs)).toList());
  }

  static salvarJogos(Jogo jogo) async {
    if (jogo.id != null) {
      await _jogos.doc(jogo.id).update(jogo.toMap());
      return jogo.id;
    } else {
      final jogoref = await _jogos.add(jogo.toMap());
      return jogoref.id;
    }
  }

  static deletarJogo(String id) async {
    await _jogos.doc(id).delete();
  }
}
