import 'package:flutter/material.dart';
import 'package:trabalho_hamburguerias/login_page.dart';
import 'package:trabalho_hamburguerias/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HamburgueriaList extends StatefulWidget {
  @override
  _HamburgueriaListState createState() => _HamburgueriaListState();
}

class _HamburgueriaListState extends State<HamburgueriaList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> hamburguerias = [
    {"name": 'Burger King', "preco": "\$\$\$", "rating": 4},
    {"name": 'McDonald\'s', "preco": "\$\$\$", "rating": 4},
    {"name": 'Uata?!', "preco": "\$\$", "rating": 3},
    {"name": 'Porpino Burger', "preco": "\$\$\$\$\$", "rating": 1},
    {"name": 'Geek Burger', "preco": "\$\$\$", "rating": 3},
    {"name": 'Bob\'s', "preco": "\$\$\$", "rating": 5},
    {"name": 'Shake Burger', "preco": "\$\$\$\$", "rating": 1},
    {"name": 'Fight Burger', "preco": "\$\$", "rating": 2},
    {"name": 'Quital Burger', "preco": "\$\$", "rating": 3},
    {"name": 'Jack Garage', "preco": "\$\$", "rating": 5},
    {"name": 'Jimmy Lanches', "preco": "\$\$\$", "rating": 2},
    {"name": 'Park Burg', "preco": "\$\$\$\$", "rating": 4},
    {"name": 'Roger Lanches', "preco": "\$\$", "rating": 4},
    {"name": 'BurguerMan', "preco": "\$\$\$", "rating": 3},
    {"name": 'Batistão Sucos', "preco": "\$\$", "rating": 2},
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController contatoController = TextEditingController();

  void _addHamburgueria() {
    String name = nameController.text;
    String preco = precoController.text;
    int rating = int.tryParse(ratingController.text) ?? 0;
    String descricao = descricaoController.text;
    String endereco = enderecoController.text;
    String contato = contatoController.text;

    if (name.isNotEmpty &&
        preco.isNotEmpty &&
        rating > 0 &&
        descricao.isNotEmpty &&
        endereco.isNotEmpty &&
        contato.isNotEmpty) {
      setState(() {
        hamburguerias.add({
          "name": name,
          "preco": preco,
          "rating": rating,
          "descricao": descricao,
          "endereco": endereco,
          "contato": contato
        });
      });

      _firestore.collection('hamburguerias').add({
        'name': name,
        'preco': preco,
        'rating': rating,
        'descricao': descricao,
        'endereco': endereco,
        'contato': contato,
      }).then((value) {
        // Feche o modal
        Navigator.of(context).pop();
      }).catchError((error) {
        print("Erro ao adicionar hamburgueria: $error");
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Por favor, preencha todos os campos."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void _showAddHamburgueriaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Hamburgueria"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: precoController,
                  decoration: InputDecoration(labelText: 'Preço'),
                ),
                TextField(
                  controller: ratingController,
                  decoration: InputDecoration(labelText: 'Classificação'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                ),
                TextField(
                  controller: enderecoController,
                  decoration: InputDecoration(labelText: 'Endereço'),
                ),
                TextField(
                  controller: contatoController,
                  decoration: InputDecoration(labelText: 'Contato'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addHamburgueria();
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

void _deleteHamburgueria(String docId, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Excluir Hamburgueria"),
        content: Text("Tem certeza de que deseja excluir esta hamburgueria?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                // Remove a hamburgueria do Firestore
                await FirebaseFirestore.instance.collection('hamburguerias').doc(docId).delete();

                // Remove a hamburgueria localmente
                setState(() {
                  hamburguerias.removeAt(index);
                });

                Navigator.of(context).pop();
              } catch (e) {
                print('Erro ao excluir hamburgueria: $e');
              }
            },
            child: Text('Confirmar'),
          ),
        ],
      );
    },
  );
}


void _showEditHamburgueriaDialog(int index) {
  // Verifica se a hamburgueria existe e não é nula
  if (hamburguerias.isNotEmpty && hamburguerias.length > index && hamburguerias[index] != null) {
    nameController.text = hamburguerias[index]['name'] ?? '';
    precoController.text = hamburguerias[index]['preco'] ?? '';
    ratingController.text = (hamburguerias[index]['rating'] ?? 0).toString();
    descricaoController.text = hamburguerias[index]['descricao'] ?? '';
    enderecoController.text = hamburguerias[index]['endereco'] ?? '';
    contatoController.text = hamburguerias[index]['contato'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Hamburgueria"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: precoController,
                  decoration: InputDecoration(labelText: 'Preço'),
                ),
                TextField(
                  controller: ratingController,
                  decoration: InputDecoration(labelText: 'Classificação'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                ),
                TextField(
                  controller: enderecoController,
                  decoration: InputDecoration(labelText: 'Endereço'),
                ),
                TextField(
                  controller: contatoController,
                  decoration: InputDecoration(labelText: 'Contato'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  hamburguerias[index] = {
                    "name": nameController.text,
                    "preco": precoController.text,
                    "rating": int.tryParse(ratingController.text) ?? 0,
                    "descricao": descricaoController.text,
                    "endereco": enderecoController.text,
                    "contato": contatoController.text
                  };
                });

                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburguerias'),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } catch (e) {
                debugPrint('Erro: $e');
              }
            },
            icon: Icon(Icons.login),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHamburgueriaDialog,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: hamburguerias.length,
        itemBuilder: (context, index) {
          final hamburgueria = hamburguerias[index];
          final String name = hamburgueria['name'];
          final int rating = hamburgueria['rating'];
          final String preco = hamburgueria['preco'];

          return Dismissible(
            key: Key(hamburgueria.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              _deleteHamburgueria(index);
            },
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsPage(hamburgueria: hamburgueria),
                  ),
                );
              },
              title: Row(
                children: [
                  Text(name),
                  SizedBox(width: 8),
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 4),
                  Text(rating.toString()),
                ],
              ),
              subtitle: Text(preco),
              leading: Icon(Icons.fastfood),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showEditHamburgueriaDialog(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
