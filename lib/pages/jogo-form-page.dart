import 'package:flutter/material.dart';
import 'package:gerenciador_jogos/models/jogo.dart';
import 'package:gerenciador_jogos/services/jogo-service.dart';

class JogoFormPage extends StatefulWidget {
  Jogo? jogo;
  JogoFormPage({super.key, this.jogo});

  @override
  State<JogoFormPage> createState() => _JogoFormPage();
}

class _JogoFormPage extends State<JogoFormPage> {
  final nomeController = TextEditingController();
  final notaController = TextEditingController();
  final plataformaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.jogo != null) {
      nomeController.text = widget.jogo!.nome;
      notaController.text = widget.jogo!.nota.toString();
      plataformaController.text = widget.jogo!.plataforma;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário de Jogo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: notaController,
              decoration: InputDecoration(labelText: 'Nota'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: plataformaController,
              decoration: InputDecoration(labelText: 'Plataforma'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (widget.jogo == null) {
                  widget.jogo = Jogo(
                    nome: nomeController.text,
                    nota: double.parse(notaController.text),
                    plataforma: plataformaController.text,
                  );
                } else {
                  widget.jogo!.nome = nomeController.text;
                  widget.jogo!.nota = double.parse(notaController.text);
                  widget.jogo!.plataforma = plataformaController.text;
                }
                try {
                  await JogoService.salvarJogos(widget.jogo!).then(
                    (jogoref) => {
                      if (jogoref != null) {widget.jogo!.id = jogoref!},
                    },
                  );
                  this.showMensagem('Jogo salvo com sucesso!', error: false);
                  Navigator.pop(context);
                } catch (e) {
                  this.showMensagem('Erro ao salvar o jogo: $e');
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  showMensagem(String msg, {bool error = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }
}
