

import 'package:flutter/material.dart';
import 'package:trabalho_casseb/login_page.dart';
import 'package:trabalho_casseb/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HamburgueriaList extends StatefulWidget {
  @override
  _HamburgueriaListState createState() => _HamburgueriaListState();
}

class _HamburgueriaListState extends State<HamburgueriaList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  List<Map<String, dynamic>> hamburguerias = [
    {"id": '1', "name": 'Burger King', "preco": "\$\$\$", "rating": 4, "descricao": "Fast food", "endereco": "Rua A", "contato": "12345"},
    {"id": '2', "name": 'McDonald\'s', "preco": "\$\$\$", "rating": 4, "descricao": "Fast food", "endereco": "Rua B", "contato": "67890"},
    {"id": '3', "name": 'Uata?!', "preco": "\$\$", "rating": 3, "descricao": "Casual", "endereco": "Rua C", "contato": "11223"},
    // adicione mais hamburguerias conforme necessário
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController contatoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

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
      String id = _firestore.collection('hamburguerias').doc().id;

      setState(() {
        hamburguerias.add({
          "id": id,
          "name": name,
          "preco": preco,
          "rating": rating,
          "descricao": descricao,
          "endereco": endereco,
          "contato": contato
        });
      });

      _firestore.collection('hamburguerias').doc(id).set({
        'name': name,
        'preco': preco,
        'rating': rating,
        'descricao': descricao,
        'endereco': endereco,
        'contato': contato,
      }).then((value) {
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
                  await _firestore.collection('hamburguerias').doc(docId).delete();
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
                      "id": hamburguerias[index]['id'],
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

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburguerias'),
        actions: [
          if (_currentUser != null)
            IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    _currentUser = null;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } catch (e) {
                  debugPrint('Erro: $e');
                }
              },
              icon: Icon(Icons.logout),
            )
          else
            IconButton(
              onPressed: _navigateToLogin,
              icon: Icon(Icons.login),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: hamburguerias.length,
        itemBuilder: (context, index) {
          final hamburgueria = hamburguerias[index];
          final name = hamburgueria['name'] ?? '';
          final preco = hamburgueria['preco'] ?? '';
          final rating = hamburgueria['rating'] ?? 0;

          return Dismissible(
            key: Key(hamburgueria['id'].toString()),
            direction: _currentUser != null ? DismissDirection.endToStart : DismissDirection.none,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              if (_currentUser != null) {
                _deleteHamburgueria(hamburgueria['id'], index);
              }
            },
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      hamburgueria: hamburgueria,
                      onDelete: () => _deleteHamburgueria(hamburgueria['id'], index),
                    ),
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
              trailing: _currentUser != null
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditHamburgueriaDialog(index);
                      },
                    )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: _currentUser != null
          ? FloatingActionButton(
              onPressed: _showAddHamburgueriaDialog,
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

