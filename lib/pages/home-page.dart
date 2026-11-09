import 'package:flutter/material.dart';
import 'package:gerenciador_jogos/models/jogo.dart';
import 'package:gerenciador_jogos/pages/jogo-form-page.dart';
import 'package:gerenciador_jogos/services/jogo-service.dart';
import 'package:gerenciador_jogos/services/login-service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem vindo ao site!'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                LoginService.logoutUsuario();
              },
              child: Text('Logout'),
            ),
            StreamBuilder<List<Jogo>>(
              stream: JogoService.listarJogos(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final jogos = snapshot.data!;
                if (jogos.isEmpty) {
                  return Text('Nenhum jogo encontrado.');
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: jogos.length,
                  itemBuilder: (context, index) {
                    final jogo = jogos[index];
                    return ListTile(
                      title: Text(jogo.nome),
                      subtitle: Text(
                        'Plataforma: ${jogo.plataforma} Nota: ${jogo.nota}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => JogoFormPage(jogo: jogo),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              final confirmacao = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirmação de exclusão'),
                                  content: Text(
                                    'Deseja realmente deletar o jogo ${jogo.nome}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: Text('Deletar'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmacao == true) {
                                JogoService.deletarJogo(jogo.id!);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => JogoFormPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
