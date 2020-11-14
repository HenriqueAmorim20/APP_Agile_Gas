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
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      body: Container(decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/agile_gas_back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 80.0),
              Image.asset('images/logo.png'),
              SizedBox(height: 10),
              RaisedButton(
                  color: Colors.transparent,
                  child: Text(
                      'Create your account!',
                      style: TextStyle(color: Colors.white, fontSize: 20)
                  ),
              ),
              SizedBox(height: 30.0),
              Container(
                width: 250,
                height: 17,
                child:
                TextFormField(
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Insira um email',

                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
                        prefixIcon: PictureWidget(),
                        prefixText: '  ',
                        prefixIconConstraints: BoxConstraints(
                          minHeight: 25,
                          minWidth: 25,
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)
                        )
                    ),

                    validator: (val) => val.isEmpty ? 'Insira um e-mail correto.' : null, //verifica se o campo está vazio
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => email = val); //mude o valor da variável email para o valor do campo
                    }
                ),

              ),
              Image.asset('images/line.png', color: Colors.white, width: 200),

              SizedBox(height: 20.0),

              Container(
                width: 250,
                height: 17,
                child:
                TextFormField(
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Insira uma Senha',
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
                        labelStyle: TextStyle(color: Colors.red),
                        prefixIcon: PictureWidget2(),
                        prefixText: '  ',

                        prefixIconConstraints: BoxConstraints(
                          minHeight: 25,
                          minWidth: 25,
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)
                        )
                    ),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Insira uma senha com +6 caracteres' : null, //verifica se a senha é menor que 6 caracteres
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => password = val); //mude o valor da variaǘel senha para o valor do campo
                    }
                ),
              ),
              Image.asset('images/line.png', color: Colors.white, width: 200),

              SizedBox(height: 20.0),
              Container(
                width: 250,
                height: 17,
                child:
                TextFormField(
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: textInputDecoration.copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Confirme a Senha',
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
                        labelStyle: TextStyle(color: Colors.red),
                        prefixIcon: PictureWidget2(),
                        prefixText: '  ',

                        prefixIconConstraints: BoxConstraints(
                          minHeight: 25,
                          minWidth: 25,
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)
                        )
                    ),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Insira uma senha com +6 caracteres' : null, //verifica se a senha é menor que 6 caracteres
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => password = val); //mude o valor da variaǘel senha para o valor do campo
                    }
                ),
              ),

              Image.asset('images/line.png', color: Colors.white, width: 200),

              SizedBox(height: 40.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreen.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(1, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),

                    child: Text(
                        'REGISTER',
                        style: TextStyle(color: Colors.black)
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
    return new ImageIcon (new AssetImage('images/username.jpg'),
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
