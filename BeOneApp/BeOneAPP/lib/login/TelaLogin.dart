import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  LoginState createState() {
    return LoginState();
  }
}
 
class LoginState extends State<Login> {
  String aviso = '';
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('BeOne'),
              backgroundColor: Colors.blueGrey,
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(builder: (BuildContext context1,
                    BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: Container(
                              child: (Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                  controller: email,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                      hintText: "Informe o email"),
                                ),
                                TextField(
                                    obscureText: true,
                                    controller: senha,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        labelText: "Senha",
                                        labelStyle: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),
                                        hintText: "Informe a senha")),
                                Text('$aviso'),
                                Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            validar();
                                          },
                                          child: Text('Login'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/cadastro1');
                                            },
                                            child: Text('Cadastrar')),
                                      ),
                                    ]),
                              ],
                            ),
                          )))));
                }))));
  }

  validar() async {
    final _mensagem = 'Usuário e/ou senha inválido(s)';
    String url =
        "http://localhost:8081/usuario/login/${email.text}/${senha.text}";
    var response = await http.get(Uri.parse(url));

    if (json.decode(response.body).toString() != "[]") {
      return Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        aviso = _mensagem;
      });
    }
  }
}
