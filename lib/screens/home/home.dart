import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: new Text('Agile Gas', style: TextStyle(
          color: Colors.lightGreenAccent[400],
          fontSize: 30,
        )),
        backgroundColor: Colors.black54,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout', style: TextStyle(
              color: Colors.lightGreenAccent[400],
              fontSize: 30,
            )),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}