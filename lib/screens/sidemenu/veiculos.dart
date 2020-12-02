import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:agile_gas_app/screens/home/car_home.dart';

class Veiculos extends StatefulWidget{

  final Function toggleView;
  Veiculos({ this.toggleView });

  @override
  _VeiculosState createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos>{

  final AuthService _auth = AuthService(); //recebe mesmo _auth do método construtor de AuthService em auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String marca='';
  String modelo='';
  String ano='';
  String motor='';
  String cor='';
  String placa='';
  String renevam='';

  @override
  Widget build(BuildContext context){
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text('Veículos'),
        leading: IconButton(
            iconSize: 75,
            icon: PictureWidget5(),
            onPressed: () async {
              Navigator.pop(context);//sinaliza para a widget que deve ser apresentada
            }
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_outlined),
            color: Colors.red,
            iconSize: 40,
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.grey[200],
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Adicionar Veículo!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),

                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    cursorColor: Colors.black.withOpacity(0.6),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      hintText: 'Marca: ex. FIAT',
                                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                    ),
                                      validator: (val) => val.isEmpty ? 'Marca inválida.' : null, //verifica se o campo está vazio
                                      onChanged: (val) { //toda vez que o valor do campo mudar
                                        setState(() => marca = val);
                                      }
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    cursorColor: Colors.black.withOpacity(0.6),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      hintText: 'Modelo: ex. Argo',
                                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),

                                    ),
                                      validator: (val) => val.isEmpty ? 'Modelo inválido.' : null, //verifica se o campo está vazio
                                      onChanged: (val) { //toda vez que o valor do campo mudar
                                        setState(() => modelo = val);
                                      }
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    cursorColor: Colors.black.withOpacity(0.6),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      hintText: 'Ano: ex. 2019',
                                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),

                                    ),
                                      validator: (val) => val.isEmpty ? 'Ano inválido.' : null, //verifica se o campo está vazio
                                      onChanged: (val) { //toda vez que o valor do campo mudar
                                        setState(() => ano = val);
                                      }
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    cursorColor: Colors.black.withOpacity(0.6),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      hintText: 'Motor: ex. 1.8 TSI',
                                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),

                                    ),
                                      validator: (val) => val.isEmpty ? 'Motor inválido.' : null, //verifica se o campo está vazio
                                      onChanged: (val) { //toda vez que o valor do campo mudar
                                        setState(() => motor = val);
                                      }
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    cursorColor: Colors.black.withOpacity(0.6),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      hintText: 'Cor: ex. Prata',
                                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),

                                    ),
                                      validator: (val) => val.isEmpty ? 'Cor inválida.' : null, //verifica se o campo está vazio
                                      onChanged: (val) { //toda vez que o valor do campo mudar
                                        setState(() => cor = val);
                                      }
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    cursorColor: Colors.black.withOpacity(0.6),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      hintText: 'Placa: ex PBE-6448',
                                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),

                                    ),
                                      validator: (val) => val.isEmpty ? 'Placa inválida.' : null, //verifica se o campo está vazio
                                      onChanged: (val) { //toda vez que o valor do campo mudar
                                        setState(() => placa = val);
                                      }
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      margin: EdgeInsets.symmetric(horizontal: 17),
                                      child:RaisedButton(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                        child: Text("CANCELAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      margin: EdgeInsets.symmetric(horizontal: 0),
                                      child: RaisedButton(
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                          child: Text("CONFIRMAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                          onPressed: () async {
                                            //Pegar todas as variaveis e armazenar no banco de dados aqui
                                          }
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      body: CarHome(),
    );
  }
}

class PictureWidget5 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/back.png'),
        color: Colors.red);
  }
}