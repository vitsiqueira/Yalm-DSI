import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  Future registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _senha.text);
      print("Usuario cadastrado");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de cadastro'),
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
                    registerUser();
                  },
                  child: Text('Cadastrar'))
            ],
          ),
        ),
      ),
    );
  }
}
