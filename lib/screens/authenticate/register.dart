import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/auth.dart';

class Register extends StatefulWidget{

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{

  final AuthService _auth = AuthService(); //recebe mesmo _auth do método construtor de AuthService em auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context){
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Agile Gas'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView(); //sinaliza para a widget que deve ser apresentada
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Insira um e-mail' : null, //verifica se o campo está vazio
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => email = val); ////mude o valor da variável email para o valor do campo
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Senha'),
                    validator: (val) => val.length < 6 ? 'Insira uma senha com +6 caracteres' : null, //verifica se a senha é menor que 6 caracteres
                    obscureText: true, //esconde caracteres escritos
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => password = val); //mude o valor da variaǘel senha para o valor do campo
                    }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) { //verifica se esse formulário possui tipos de dados corretos
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password); //se sim loga o usuário com essa senha e base
                        if(result == null){ //retorna null se não tiver conseguido cadastrar
                          setState(() {
                            error = 'Registration failed!';
                            loading = false;
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ]
          ),
        ),
      ),
    );
  }
}