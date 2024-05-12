import 'package:flutter/material.dart';
import 'package:trabalho_hamburguerias/login_page.dart';

class HamburgueriaList extends StatelessWidget {
  final List<Map<String, dynamic>> hamburguerias = [
    {"name": 'Burger King', "price": "\$\$\$", "rating": 4},
    {"name": 'McDonald\'s', "price": "\$\$\$", "rating": 4},
    {"name": 'Uata?!', "price": "\$\$", "rating": 3},
    {"name": 'Porpino Burger', "price": "\$\$\$\$\$", "rating": 1},
    {"name": 'Geek Burger', "price": "\$\$\$", "rating": 3},
    {"name": 'Bob\'s', "price": "\$\$\$", "rating": 5},
    {"name": 'Shake Burger', "price": "\$\$\$\$", "rating": 1},
    {"name": 'Fight Burger', "price": "\$\$", "rating": 2},
    {"name": 'Quital Burger', "price": "\$\$", "rating": 3},
    {"name": 'Jack Garage', "price": "\$\$", "rating": 5},
    {"name": 'Jimmy Lanches', "price": "\$\$\$", "rating": 2},
    {"name": 'Park Burg', "price": "\$\$\$\$", "rating": 4},
    {"name": 'Roger Lanches', "price": "\$\$", "rating": 4},
    {"name": 'BurguerMan', "price": "\$\$\$", "rating": 3},
    {"name": 'Batistão Sucos', "price": "\$\$", "rating": 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburguerias'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.login),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: hamburguerias.length,
        itemBuilder: (context, index) {
          final String name = hamburguerias[index]['name'];
          final int rating = hamburguerias[index]['rating'];
          final String price = hamburguerias[index]['price'];

          return ListTile(
            title: Row(
              children: [
                Text(name),
                SizedBox(width: 8),
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 4),
                Text(rating.toString()),
              ],
            ),
            subtitle: Text(price),
            leading: Icon(Icons.fastfood),
          );
        },
      ),
    );
  }
}
