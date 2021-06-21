import 'dart:convert';

import 'package:beone_app/Cadastro/TelaCadastroCNPJ.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Argumentos.dart';
import 'TelaCadastroCPF.dart';

class CadastroEndereco extends StatefulWidget {
  @override
  _CadastroEndereco createState() => _CadastroEndereco();
}

class _CadastroEndereco extends State<CadastroEndereco> {
  final _formKey = GlobalKey<FormState>();
  var textCep = TextEditingController();
  var textRua = TextEditingController();
  var textBairro = TextEditingController();
  var textCidade = TextEditingController();
  var textEstado = TextEditingController();
  var textNum = TextEditingController();
  var nomerazao = "",
      data = "",
      cpfcnpj = "",
      email = "",
      senha = "",
      sexoramo = "";

  var tipo = 0;

  @override
  Widget build(BuildContext context) {
    Argumentos argumentos =
        ModalRoute.of(context)!.settings.arguments as Argumentos;

    this.nomerazao = argumentos.nomerazao;
    this.data = argumentos.data;
    this.cpfcnpj = argumentos.cpfcnpj;
    this.email = argumentos.email;
    this.senha = argumentos.senha;
    this.sexoramo = argumentos.sexoramo;
    this.tipo = argumentos.tipo;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('BeOne'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder:
                (BuildContext context1, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  child: (Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "CEP",
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              hintText: "Informe seu CEP",
                            ),
                            controller: textCep,
                            validator: (cep) {
                              if (cep == '') {
                                return "Informe um CEP";
                              }
                              return null;
                            },
                            onChanged: (cep) async {
                              if (cep.length == 8) {
                                String url =
                                    'https://viacep.com.br/ws/$cep/json/';
                                http.Response response;
                                response = await http.get(url);
                                Map<String, dynamic> retorno =
                                    json.decode(response.body);
                                setState(() {
                                  textRua.text = retorno["logradouro"];
                                  textBairro.text = retorno["bairro"];
                                  textCidade.text = retorno["localidade"];
                                  textEstado.text = retorno['uf'];
                                });
                              }
                            },
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Rua",
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              hintText: "Informe sua rua",
                            ),
                            controller: textRua,
                            validator: (rua) {
                              if (rua == '') {
                                return "Informe uma rua";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "número",
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              hintText: "Informe seu número",
                            ),
                            controller: textNum,
                            validator: (rua) {
                              if (rua == '') {
                                return "Informe um número";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Bairro",
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              hintText: "Informe seu bairro",
                            ),
                            controller: textBairro,
                            validator: (bairro) {
                              if (bairro == '') {
                                return "Informe um bairro";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Cidade",
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              hintText: "Informe sua cidade",
                            ),
                            controller: textCidade,
                            validator: (cidade) {
                              if (cidade == '') {
                                return "Informe uma cidade";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Estado",
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              hintText: "Informe seu estado",
                            ),
                            controller: textEstado,
                            validator: (estado) {
                              if (estado == '') {
                                return "Informe um estado";
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                                Navigator.pushNamed(context, '/login');
                              }

                              if (this.tipo == 1) {
                                postUsuario();
                              } else if (this.tipo == 2) {
                                postEmpresa();
                              }
                            },
                            child: Text('Seguinte'),
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }

  postUsuario() async {
    String cep = textCep.text;
    String rua = textRua.text;
    String bairro = textBairro.text;
    String cidade = textCidade.text;
    String estado = textEstado.text;
    String numero = textNum.text;

    var link =
        'http://localhost:8081/pessoa/insert/$email/$cpfcnpj/$data/$nomerazao/$sexoramo/$senha/$estado/$cidade/$bairro/$rua/$cep/$numero';

    var response = await http.get(link);
  }

  postEmpresa() async {
    String cep = textCep.text;
    String rua = textRua.text;
    String bairro = textBairro.text;
    String cidade = textCidade.text;
    String estado = textEstado.text;
    String numero = textNum.text;

    var link =
        "http://localhost:8081/empresa/insert/$email/$cpfcnpj/$nomerazao/$senha/$estado/$cidade/$bairro/$rua/$numero/$cep";

    var response = await http.get(link);
  }
}
