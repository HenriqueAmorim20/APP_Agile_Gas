import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:flutter/cupertino.dart';
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

      body: Container(
        color: Colors.grey[900],
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              Image.asset('images/logo.png', color: Colors.red),
              SizedBox(height: 130),
              Container(
                width: 250,
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
                        hintText: 'exemplo@email.com',
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
                      setState(() => email = val); //mude o valor da variável email para o valor do campo
                    }
                ),

              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5)),


              SizedBox(height: 20.0),

              Container(
                width: 250,
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
                        hintText: 'Senha',
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
                        labelStyle: TextStyle(color: Colors.red),
                        prefixIcon: PictureWidget2(),
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
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Senha incorreta!' : null, //verifica se a senha é menor que 6 caracteres
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => password = val); //mude o valor da variaǘel senha para o valor do campo
                    }
                ),
              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5)),


              SizedBox(height: 40.0),
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
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),

                    child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) { //verifica se esse formulário possui tipos de dados corretos
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password); //se sim loga o usuário com essa senha e base
                        if (result == null) { //retorna null se não estiver cadastrado
                          setState(() {
                            error = 'Credenciais inválidas, cadastre-se!';
                            loading = false;
                          });
                        }
                      }
                    }
                ),
              ),

              SizedBox(height: 30),
              Container(
                child: FlatButton(
                    color: Colors.grey[900],

                    child: Text(
                        'Não tem uma conta? Crie aqui!',
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.underline)
                    ),
                    onPressed: () async {
                      widget.toggleView();
                    }
                ),

              ),
              Container(
                child: FlatButton(
                    color: Colors.grey[900],
                    child: Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.underline)
                    ),
                    onPressed: () async {

                    }
                ),
              ),

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
