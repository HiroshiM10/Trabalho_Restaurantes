
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> hamburgueria;
  final VoidCallback onDelete;

  DetailsPage({required this.hamburgueria, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hamburgueria['name'] ?? 'Detalhes da Hamburgueria'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preço: ${hamburgueria['preco'] ?? 'Não especificado'}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Classificação: ${hamburgueria['rating'] ?? 'Não especificado'}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Descrição: ${hamburgueria['descricao'] ?? 'Não especificado'}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Endereço: ${hamburgueria['endereco'] ?? 'Não especificado'}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Contato: ${hamburgueria['contato'] ?? 'Não especificado'}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
