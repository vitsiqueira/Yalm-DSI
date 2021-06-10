import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAuth extends StatefulWidget {
  const LoginAuth({Key? key}) : super(key: key);

  @override
  _LoginAuthState createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  Future loginAuth() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _senha.text);
      print("Logado!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Escreva seu email"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _senha,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Escreva sua senha"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    loginAuth();
                  },
                  child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
