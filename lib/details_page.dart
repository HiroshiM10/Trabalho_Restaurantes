import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> hamburgueria;

  DetailsPage({required this.hamburgueria});

  @override
  Widget build(BuildContext context) {
    final String name = hamburgueria['name'];
    final String preco = hamburgueria['preco'];
    final int rating = hamburgueria['rating'];
    final String descricao = hamburgueria['descricao'] ?? 'Sem descrição';
    final String endereco = hamburgueria['endereco'] ?? 'Sem endereço';
    final String contato = hamburgueria['contato'] ?? 'Sem contato';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Preço: $preco',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Classificação: ',
                  style: TextStyle(fontSize: 18),
                ),
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Descrição',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              descricao,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Endereço',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              endereco,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
                           'Contato',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              contato,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

