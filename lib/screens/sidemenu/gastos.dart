import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/auth.dart';

import '../home/car_home_gastos.dart';

class Gastos extends StatefulWidget{

  final Function toggleView;
  Gastos({ this.toggleView });

  @override
  _GastosState createState() => _GastosState();
}

class _GastosState extends State<Gastos>{

  final AuthService _auth = AuthService(); //recebe mesmo _auth do método construtor de AuthService em auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context){
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text('Acompanhamento de Gastos'),
        leading: IconButton(
            iconSize: 75,
            icon: PictureWidget5(),
            onPressed: () async {
              Navigator.pop(context);//sinaliza para a widget que deve ser apresentada
            }
        ),
      ),
      body: CarHomeGastos(),
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