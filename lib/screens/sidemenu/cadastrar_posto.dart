import 'package:agile_gas_app/screens/map/add.posto.dart';
import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/auth.dart';

class Cadastrar_posto extends StatefulWidget {
  final Function toggleView;
  Cadastrar_posto({this.toggleView});

  @override
  _Cadastrar_postoState createState() => _Cadastrar_postoState();
}

class _Cadastrar_postoState extends State<Cadastrar_posto> {
  final AuthService _auth =
      AuthService(); //recebe mesmo _auth do método construtor de AuthService em auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: new AppBar(
              backgroundColor: Colors.black,
              title: Text('Cadastrar posto'),
              leading: IconButton(
                  iconSize: 75,
                  icon: PictureWidget5(),
                  onPressed: () async {
                    Navigator.pop(
                        context); //sinaliza para a widget que deve ser apresentada
                  }),
            ),
            body: Container(
              child: App(),
            ),
          );
  }
}

class PictureWidget5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(new AssetImage('images/back.png'), color: Colors.red);
  }
}
