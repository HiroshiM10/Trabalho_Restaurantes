import 'package:flutter/material.dart';

//chama a função principal
void main() {
  runApp(HamburgueriaApp());
}


class HamburgueriaApp extends StatelessWidget {
  //retorna a interface (obrigatório em qualquer código flutter)
  @override
  Widget build(BuildContext context) {
    //define a estrutura básica do aplicativo
    return MaterialApp(
      title: 'Hamburguerias',
      //página principal
      home: HamburgueriaList(),
    );
  }
}

//definindo uma lista de objetos do tipo Hamburgueria
class HamburgueriaList extends StatelessWidget {
  final List<Hamburgueria> hamburguerias = [
    Hamburgueria(name: 'Burger King', location: 'Av. Nª Sra. de Nazaré, 759 - Nazaré'),
    Hamburgueria(name: 'McDonald\'s', location: 'R. Antônio Barreto, 166 - Umarizal'),
    Hamburgueria(name: 'Uata?!', location: 'R. Antônio Barreto, 287 - Umarizal'),
    Hamburgueria(name: 'Porpino Burger', location: 'R. Cônego Jerônimo Pimentel, 242 - Umarizal'),
    Hamburgueria(name: 'Geek Burger', location: 'R. João Balbi, 1291 - Nazaré'),
    Hamburgueria(name: 'Bob\'s', location: 'Av. Duque de Caxias, 608 - Marco'),
    Hamburgueria(name: 'Shake Burger', location: 'Av. Cmte. Brás de Aguiar, 312 - Nazaré'),
    Hamburgueria(name: 'Fight Burger', location: 'Travessa Angustura, 2369 - Pedreira'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
    Hamburgueria(name: 'xxxxxxxxxx', location: 'xxxxxxxxxx'),
  ];

  //interface do usuário da lista de hamburguerias
  @override
  Widget build(BuildContext context) {
    //Scaffold = layout básico do material design
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburguerias'),
      ),
      body: ListView.builder(
        itemCount: hamburguerias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(hamburguerias[index].name),
            subtitle: Text(hamburguerias[index].location),
            leading: Icon(Icons.fastfood),
            
          );
        },
      ),
    );
  }
}

//aqui usa o construtor hamburgueria, pra inicializar os atributos quando for criado um objeto novo
class Hamburgueria {
  final String name;
  final String location;


  Hamburgueria({required this.name, required this.location});
}



