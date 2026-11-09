import 'package:cloud_firestore/cloud_firestore.dart';

class Jogo {
  String? id;
  String nome;
  double nota;
  String plataforma;

  Jogo({
    this.id,
    required this.nome,
    required this.nota,
    required this.plataforma,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'nota': nota, 'plataforma': plataforma};
  }

  factory Jogo.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final dados = doc.data()!;
    return Jogo(
      id: doc.id,
      nome: dados['nome'],
      nota: dados['nota'],
      plataforma: dados['plataforma'],
    );
  }
}
