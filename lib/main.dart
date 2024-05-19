import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trabalho_casseb/login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'hamburgueria_list.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HamburgueriaList(), 
    );
  }
}


class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        
        if (!snapshot.hasData) {
          debugPrint("n logado");
          return HamburgueriaList();
        }

        debugPrint("logado");
        
        return LoginPage();
      },
    );
    
  }
}
