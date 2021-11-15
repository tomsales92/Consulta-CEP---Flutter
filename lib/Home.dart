import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado";

  _recuperaCep() async {
    String cepDigitado = _controllerCep.text;
    //Uri url = Uri.parse("https://viacep.com.br/ws/${cepDigitado}/json/");
    String valorURL = "https://viacep.com.br/ws/${cepDigitado}/json/";
    Uri url = Uri.parse(valorURL);
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro},${complemento}${bairro}";
    });
    
    print(
      "Resposta logradouro: ${logradouro} complemento: ${complemento} bairro: ${bairro} "
    );
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta CEP"),
        ) ,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Digite o cep ex: 05428200"
            ),
            style: TextStyle(
              fontSize: 20
            ),
            controller: _controllerCep,
          ),
          ElevatedButton(
            child: Text('Clique Aqui'),
            onPressed: _recuperaCep,
            ),
            Text(_resultado)
        ],),
      ),
    );
  }
}