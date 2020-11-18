import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey [900],
      appBar: new AppBar(
        backgroundColor: Colors.grey[900],
        title: Image.asset('images/logo.png', color: Colors.red, height: 50, width: 150,),
      ),
      body: Center(child: Text('Teste')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Text('Cabeçalho'),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
            ),
            ListTile(
              title: Text('Veículos'),
              onTap: () {
                Navigator.pop(context);
              }
            ),
            ListTile(
                title: Text('Acompanhar Gastos'),
                onTap: () {
                  Navigator.pop(context);
                }
            ),
            ListTile(
                title: Text('Cadastrar Posto'),
                onTap: () {
                  Navigator.pop(context);
                }
            ),
            ListTile(
                title: Text('Registrar Abastecimento'),
                onTap: () {
                  Navigator.pop(context);
                }
            ),
            ListTile(
                title: Text('Configurações'),
                onTap: () {
                  Navigator.pop(context);
                }
            ),
            ListTile(
                title: Text('Deixe sua Sugestão'),
                onTap: () {
                  Navigator.pop(context);
                }
            ),
            ListTile(
                title: Text('Sair'),
                onTap: () {
                  Navigator.pop(context);
                   _auth.signOut();
                }
            ),
          ],
        ),
      ),
    );
  }
}