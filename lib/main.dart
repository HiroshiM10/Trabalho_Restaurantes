
import 'package:flutter/material.dart';
import 'package:trabalho_hamburguerias/login_page.dart';
import 'package:trabalho_hamburguerias/hamburgueria_list.dart';

void main() {
  runApp(HamburgueriaApp());
}

class HamburgueriaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamburguerias',
      home: HamburgueriaList(), // Inicia na tela da lista de hamburguerias
    );
  }
}
