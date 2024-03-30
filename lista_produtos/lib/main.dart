import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController nomeControlador = TextEditingController();
  final TextEditingController descricaoControlador = TextEditingController();
  var modoAdicionaTarefa = true;
  var registro = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarefas'),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nomeControlador,
                decoration: const InputDecoration(
                  hintText: 'Nome da Tarefa',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descricaoControlador,
                decoration: const InputDecoration(
                  hintText: 'Descrição da Tarefa',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ElevatedButton(
                onPressed: () {
                  if (nomeControlador.text.isEmpty ||
                      descricaoControlador.text.isEmpty) {
                    return;
                  } else {
                    setState(() {
                      if (modoAdicionaTarefa == true) {
                        _tarefas.add(
                          Tarefa(
                            nome: nomeControlador.text,
                            descricao: descricaoControlador.text,
                            status: false,
                          ),
                        );
                        nomeControlador.clear();
                        descricaoControlador.clear();
                      } else {
                        setState(() {
                          _tarefas[registro].nome = nomeControlador.text;
                          _tarefas[registro].descricao =
                              descricaoControlador.text;
                        });
                        nomeControlador.clear();
                        descricaoControlador.clear();
                        setState(() {
                          modoAdicionaTarefa = true;
                          registro = -1;
                        });
                      }
                    });
                  }
                },
                child: Text(
                    modoAdicionaTarefa ? 'Adicionar Tarefa' : 'Editar Tarefa'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tarefas[index].nome),
                    subtitle: Text(_tarefas[index].descricao),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _tarefas[index].status,
                          onChanged: (bool? value) {
                            setState(() {
                              _tarefas[index].status = value ?? false;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              modoAdicionaTarefa = false;
                              nomeControlador.text = _tarefas[index].nome;
                              descricaoControlador.text =
                                  _tarefas[index].descricao;
                              registro = index;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _tarefas.removeAt(index);
                            setState(() {
                              _tarefas.iterator;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void removeDaLista(int index, List<Tarefa> tarefas) {}
}

class Tarefa {
  String nome;
  String descricao;
  bool status;

  Tarefa({
    required this.nome,
    required this.descricao,
    required this.status,
  });
}
