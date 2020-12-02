import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/auth.dart';

class Registrar_abastecimento extends StatefulWidget{

  final Function toggleView;
  Registrar_abastecimento({ this.toggleView });

  @override
  _Registrar_abastecimentoState createState() => _Registrar_abastecimentoState();
}

class _Registrar_abastecimentoState extends State<Registrar_abastecimento>{

  final AuthService _auth = AuthService(); //recebe mesmo _auth do método construtor de AuthService em auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

 //text field state
  String posto = '';
  String combustivel = '';
  String valorLitro = '';
  String valorAbastecido = '';
  String atndimento = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
            iconSize: 75,
            icon: PictureWidget5(),
            onPressed: () async {
              Navigator.pop(
                  context); //sinaliza para a widget que deve ser apresentada
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[900],
              padding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              constraints: BoxConstraints(
                minHeight: 500,
                maxHeight: 770,
              ),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 0),
                  Image.asset('images/logo.png', color: Colors.red),
                  SizedBox(height: 15),
                  FlatButton(
                    color: Colors.transparent,
                    onPressed: () {},
                    child: Text('Registrar Abastecimento!',
                        style:
                        TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    width: 250,
                    height: 30,
                    child: TextFormField(
                        cursorColor: Colors.white.withOpacity(0.6),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            hintText: 'Nome do Posto',
                            hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white.withOpacity(0.6)),
                            prefixIcon: PictureWidget4(),
                            prefixText: '  ',
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            filled: true,
                            fillColor: Colors.grey[900],
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent))),
                        validator: (val) => val.isEmpty
                            ? 'Este campo não pode estar vazio.'
                            : null, //verifica se o campo está vazio
                        onChanged: (val) {
                          //toda vez que o valor do campo mudar
                          //setState(() => nome =
                          //    val); //mude o valor da variável email para o valor do campo
                        }),
                  ),
                  Image.asset('images/line.png',
                      color: Colors.red.withOpacity(0.5), width: 200),
                  SizedBox(height: 15.0),
                  Container(
                    width: 250,
                    height: 30,
                    child: TextFormField(
                        cursorColor: Colors.white.withOpacity(0.6),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            hintText: 'Tipo de Combustível',
                            hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white.withOpacity(0.6)),
                            prefixIcon: PictureWidget4(),
                            prefixText: '  ',
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            filled: true,
                            fillColor: Colors.grey[900],
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent))),
                        validator: (val) => val.isEmpty
                            ? 'Este campo não pode estar vazio.'
                            : null, //verifica se o campo está vazio
                        onChanged: (val) {
                          //toda vez que o valor do campo mudar
                          //setState(() => cpf =
                          //    val); //mude o valor da variável email para o valor do campo
                        }),
                  ),
                  Image.asset('images/line.png',
                      color: Colors.red.withOpacity(0.5), width: 200),
                  SizedBox(height: 15.0),
                  Container(
                    width: 250,
                    height: 30,
                    child: TextFormField(
                        cursorColor: Colors.white.withOpacity(0.6),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            hintText: 'Valor do Litro',
                            hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white.withOpacity(0.6)),
                            prefixIcon: PictureWidget4(),
                            prefixText: '  ',
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            filled: true,
                            fillColor: Colors.grey[900],
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent))),
                        validator: (val) => val.isEmpty
                            ? 'Este campo não pode estar vazio.'
                            : null, //verifica se o campo está vazio
                        onChanged: (val) {
                          //toda vez que o valor do campo mudar
                          //setState(() => email =
                          //    val); //mude o valor da variável email para o valor do campo
                        }),
                  ),
                  Image.asset('images/line.png',
                      color: Colors.red.withOpacity(0.5), width: 200),
                  SizedBox(height: 15.0),
                  Container(
                    width: 250,
                    height: 30,
                    child: TextFormField(
                        cursorColor: Colors.white.withOpacity(0.6),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            hintText: 'Valor Abastecido',
                            hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white.withOpacity(0.6)),
                            prefixIcon: PictureWidget4(),
                            prefixText: '  ',
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            filled: true,
                            fillColor: Colors.grey[900],
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent))),
                         validator: (val) => val.isEmpty
                            ? 'Este campo não pode estar vazio.'
                            : null, //verifica se o campo está vazio
                        onChanged: (val) {
                          //toda vez que o valor do campo mudar
                          //setState(() => email =
                          //    val); //mude o valor da variável email para o valor do campo
                        }),
                  ),
                  Image.asset('images/line.png',
                      color: Colors.red.withOpacity(0.5), width: 200),
                  SizedBox(height: 15.0),
                  Container(
                    width: 250,
                    height: 30,
                    child: TextFormField(
                        cursorColor: Colors.white.withOpacity(0.6),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            hintText: 'Avaliação do Atendimento',
                            hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white.withOpacity(0.6)),
                            prefixIcon: PictureWidget4(),
                            prefixText: '  ',
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            filled: true,
                            fillColor: Colors.grey[900],
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent))),
                         validator: (val) => val.isEmpty
                            ? 'Este campo não pode estar vazio.'
                            : null, //verifica se o campo está vazio
                        onChanged: (val) {
                          //toda vez que o valor do campo mudar
                          //setState(() => email =
                          //    val); //mude o valor da variável email para o valor do campo
                        }),
                  ),
                  Image.asset('images/line.png',
                      color: Colors.red.withOpacity(0.5), width: 150),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                          Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                        child: Text('REGISTRAR ABASTECIMENTO',
                        textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            //verifica se esse formulário possui tipos de dados corretos
                            setState(() => loading = true);
                            //dynamic result =
                            //if (result == null) {
                              //retorna null se não tiver conseguido cadastrar
                              setState(() {
                                //error = 'Registration failed!';
                                loading = false;
                              });
                            }
                          }
                        ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PictureWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(new AssetImage('images/dot.png'), color: Colors.white);
  }
}


class PictureWidget5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(new AssetImage('images/back.png'), color: Colors.red);
  }
}
