import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget{

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{

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

      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        decoration: BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("images/logo.png"), fit: BoxFit.contain),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 400.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email: exemplo@email.com'),
                validator: (val) => val.isEmpty ? 'Insira um e-mail.' : null, //verifica se o campo está vazio
                onChanged: (val){ //toda vez que o valor do campo mudar
                  setState(() => email = val); //mude o valor da variável email para o valor do campo
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Senha'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Senha incorreta!' : null, //verifica se a senha é menor que 6 caracteres
                  onChanged: (val){ //toda vez que o valor do campo mudar
                    setState(() => password = val); //mude o valor da variaǘel senha para o valor do campo
                  }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.white,
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.black)
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) { //verifica se esse formulário possui tipos de dados corretos
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password); //se sim loga o usuário com essa senha e base
                    if (result == null) { //retorna null se não estiver cadastrado
                      setState(() {
                        error = 'Sign in failed, credentials not registered!';
                        loading = false;
                      });
                    }
                  }
                }
              ),
              RaisedButton(
                  color: Colors.black,
                  child: Text(
                      'Create your account!',
                      style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    widget.toggleView();
                  }
              ),
              RaisedButton(
                  color: Colors.black,
                  child: Text(
                      'Forgot you password?',
                      style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {

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