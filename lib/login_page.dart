import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabalho_hamburguerias/hamburgueria_list.dart';

import 'register_page.dart';
//import 'forget_password.dart';
//import 'home.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  void _loginUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HamburgueriaList()),
      );
    } catch (e) {
      print('Error: $e');
      errorMessage = 'Credenciais inválidas. Por favor, verifique e tente novamente.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
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
              onPressed: () => _loginUser(context),
              child: const Text('Login'),
            ),
            errorMessage.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container(),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text("Você ainda não tem conta? Registre-se"),
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
