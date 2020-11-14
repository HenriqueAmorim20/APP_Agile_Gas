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
  String nome = '';
  String cpf = '';
  String username = '';

  @override
  Widget build(BuildContext context){
    return loading ? Loading() : Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey[900],
        title: IconButton(
            iconSize: 35,
            icon: PictureWidget5(),
            onPressed: () async {
              widget.toggleView(); //sinaliza para a widget que deve ser apresentada
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
              SizedBox(height: 10),
              Image.asset('images/logo.png', color: Colors.red),
              SizedBox(height: 10),
              FlatButton(
                  color: Colors.transparent,
                  child: Text(
                      'Crie sua conta!',
                      style: TextStyle(color: Colors.white, fontSize: 15)
                  ),
              ),
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
                        hintText: 'Nome',
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

                    validator: (val) => val.isEmpty ? 'Insira um nome válido.' : null, //verifica se o campo está vazio
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => nome = val); //mude o valor da variável email para o valor do campo
                    }
                ),

              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

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
                        hintText: 'CPF',
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

                    validator: (val) => val.isEmpty ? 'Insira um CPF válido.' : null, //verifica se o campo está vazio
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => cpf = val); //mude o valor da variável email para o valor do campo
                    }
                ),

              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

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
                        hintText: 'Usuário',
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

                    validator: (val) => val.isEmpty ? 'Insira um usuário válido.' : null, //verifica se o campo está vazio
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => email = val); //mude o valor da variável email para o valor do campo
                    }
                ),

              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

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
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

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
                    validator: (val) => val.length < 6 ? 'Insira uma senha com +6 caracteres' : null, //verifica se a senha é menor que 6 caracteres
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => password = val); //mude o valor da variaǘel senha para o valor do campo
                    }
                ),

              ),

              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

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
                        hintText: 'Confirme  sua senha',
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.6)),
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
                    validator: (val) => val.length < 6 ? 'Insira uma senha com +6 caracteres' : null, //verifica se a senha é menor que 6 caracteres
                    onChanged: (val){ //toda vez que o valor do campo mudar
                      setState(() => password = val); //mude o valor da variaǘel senha para o valor do campo
                    }
                ),

              ),
              Image.asset('images/line.png', color: Colors.red.withOpacity(0.5), width: 200),

              SizedBox(height: 20.0),
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
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),

                    child: Text(
                        'REGISTRAR',
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
