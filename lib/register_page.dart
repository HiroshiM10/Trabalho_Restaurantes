import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho_hamburguerias/hamburgueria_list.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _registerUser(BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HamburgueriaList()),
      );
    } catch (e) {
        print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Registrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _registerUser(context),
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Já tem uma conta? Faça login aqui'),
            ),
            // const SizedBox(height: 16.0),
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
            //     );
            //   },
            //   child: const Text('Esqueceu a senha?'),
            // ),
            IconButton(
            onPressed: () async {
             
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HamburgueriaList()),
                );
              
            },
            icon: Icon(Icons.login),
          ),
          ],
        ),
      ),
    );
  }
}
