import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:agile_gas_app/screens/authenticate/sign_in.dart';

class Password extends StatefulWidget{

  final Function toggleView;
  Password({ this.toggleView });

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password>{

  final AuthService _auth = AuthService(); //recebe mesmo _auth do método construtor de AuthService em auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String emailrec = '';
  String error = '';
  String nome = '';
  String cpfrec = '';


  @override
  Widget build(BuildContext context){
    return loading ? Loading() : Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
            iconSize: 75,
            icon: PictureWidget5(),
            onPressed: () async {
              Navigator.pop(context); //sinaliza para a widget que deve ser apresentada
            }
        ),
      ),
      
      body: Container(
        color: Colors.grey[900],
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),

        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset('images/logo.png', color: Colors.red),
              SizedBox(height: 80),
              Container(
                width: 300,
                height: 30,
                child:
                TextFormField(
                    cursorColor: Colors.white.withOpacity(0.6),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Insira seu nome',
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
                        prefixIcon: PictureWidget3(),
                        prefixText: '  ',
                        prefixIconConstraints: BoxConstraints(
                          minHeight: 25,
                          minWidth: 25,
                        ),
                        filled: true,
                        fillColor: Colors.grey[900],
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent)
                        )
                    ),
                ),

              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

              SizedBox(height: 30.0),
              Container(
                width: 300,
                height: 30,
                child:
                TextFormField(
                    cursorColor: Colors.white.withOpacity(0.6),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Insira seu e-mail cadastrado',
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
                        prefixIcon: PictureWidget(),
                        prefixText: '  ',
                        prefixIconConstraints: BoxConstraints(
                          minHeight: 25,
                          minWidth: 25,
                        ),
                        filled: true,
                        fillColor: Colors.grey[900],
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent)
                        )
                    ),

                    validator: (val) => val.isEmpty ? 'Insira um e-mail.' : null, //verifica se o campo está vazio
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => emailrec = val); //mude o valor da variável email para o valor do campo
                    }
                ),

              ),

              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

              SizedBox(height: 30.0),
              Container(
                width: 300,
                height: 30,
                child:
                TextFormField(
                    cursorColor: Colors.white.withOpacity(0.6),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Insira seu CPF cadastrado',
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
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
                            borderSide: BorderSide(color: Colors.transparent)
                        )
                    ),

                    validator: (val) => val.isEmpty ? 'Insira um CPF.' : null, //verifica se o campo está vazio
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => cpfrec = val); //mude o valor da variável email para o valor do campo
                    }
                ),

              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

              SizedBox(height: 30.0),
              Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),

                    child: Text(
                        'RECUPERAR SENHA',
                        style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async {

                    }

                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class PictureWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/email.png'),
    color: Colors.white);
  }
}


class PictureWidget2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/password.png'),
        color: Colors.white);
  }
}

class PictureWidget3 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/username.jpg'),
        color: Colors.white);
  }
}

class PictureWidget4 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/dot.png'),
        color: Colors.white);
  }
}

class PictureWidget5 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/back.png'),
        color: Colors.red);
  }
}
