import 'package:agile_gas_app/shared/constants.dart';
import 'package:agile_gas_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:agile_gas_app/models/agilegasuser.dart';


class Configuracoes extends StatefulWidget{

  final Function toggleView;
  Configuracoes({ this.toggleView });

  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes>{

  final AuthService _auth = AuthService(); //recebe mesmo _auth do método construtor de AuthService em auth.dart
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String old_email = '';
  String senha='';
  String novo_nome='';
  String novo_email='';
  String novo_cpf='';
  String senhaDel = '';

  @override
  Widget build(BuildContext context){

    final user = Provider.of<AgileGasUser>(context, listen: false);

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text('Configurações'),
        leading: IconButton(
            iconSize: 75,
            icon: PictureWidget5(),
            onPressed: () async {
              Navigator.pop(context);//sinaliza para a widget que deve ser apresentada
            }
        ),
      ),
      body: SingleChildScrollView(
        child:Container(
          margin: new EdgeInsets.symmetric(vertical:15, horizontal: 10),
          height:400,
          padding: EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                  bottomLeft: const Radius.circular(25),
                  bottomRight: const Radius.circular(25)
              )
          ),
          child: Column(
            children: [
              Container(
                height: 400.0,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20),
                    ListTile(
                        leading: Icon(Icons.face,
                            color: Colors.white),
                        title: Text("Altere seu Nome", style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.grey[200],
                                  content: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Alterar nome!",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),

                                                )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  cursorColor: Colors.black.withOpacity(0.6),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: textInputDecoration.copyWith(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    hintText: 'Digite seu novo nome',
                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                  ),
                                                  validator: (val) => val.isEmpty ? 'Nome inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => novo_nome = val);
                                                  }
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  cursorColor: Colors.black.withOpacity(0.6),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: textInputDecoration.copyWith(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    hintText: 'Valide sua senha',
                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                  ),
                                                  validator: (val) => val.isEmpty ? 'Senha inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => senha = val);
                                                  }
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.symmetric(horizontal: 17),
                                                  child:RaisedButton(
                                                    color: Colors.red,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                    child: Text("CANCELAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                                  child: RaisedButton(
                                                      color: Colors.red,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                      child: Text("CONFIRMAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                      onPressed: () async {
                                                        final user = Provider.of<AgileGasUser>(context, listen: false); //pega o usuario atual
                                                        final usersRef = FirebaseFirestore.instance.collection('users'); //acessa o doc dos usuarios

                                                        usersRef.get().then((snapshot){
                                                          snapshot.docs.forEach((doc){ //percorre os docs
                                                            if(doc.data()['uid'] == user.uid){ //até encontrar o do usuario atual
                                                              var result = _auth.signInWithEmailAndPassword(doc.data()['email'], senha);
                                                              if(result != null){
                                                                FirebaseFirestore.instance.collection('users').doc(user.uid).update({"name": novo_nome});
                                                              } else {
                                                                Navigator.pop(context);
                                                              }
                                                            }
                                                          });
                                                        });

                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    ListTile(
                        leading: Icon(Icons.email,
                            color: Colors.white),
                        title: Text("Altere seu Email", style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.grey[200],
                                  content: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Altere seu Email!",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),

                                                )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  cursorColor: Colors.black.withOpacity(0.6),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: textInputDecoration.copyWith(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    hintText: 'Digite seu novo email',
                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                  ),
                                                  validator: (val) => val.isEmpty ? 'Email inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => novo_email = val);
                                                  }
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  cursorColor: Colors.black.withOpacity(0.6),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: textInputDecoration.copyWith(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    hintText: 'Valide sua senha',
                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                  ),
                                                  validator: (val) => val.isEmpty ? 'Senha inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => senha = val);
                                                  }
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.symmetric(horizontal: 17),
                                                  child:RaisedButton(
                                                    color: Colors.red,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                    child: Text("CANCELAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                                  child: RaisedButton(
                                                      color: Colors.red,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                      child: Text("CONFIRMAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                      onPressed: () async {

                                                        final user = Provider.of<AgileGasUser>(context, listen: false); //pega o usuario atual
                                                        final usersRef = FirebaseFirestore.instance.collection('users'); //acessa o doc dos usuarios
                                                        print("UID: " + user.uid);

                                                        usersRef.get().then((snapshot){
                                                          snapshot.docs.forEach((doc){ //percorre os docs
                                                            if(doc.data()['uid'] == user.uid){ //até encontrar o do usuario atual
                                                              print("EMAIL ENCONTRADO: " + doc.data()['email']);
                                                              _auth.changeEmail(novo_email, doc.data()['email'], senha);  //atualiza o email
                                                            }
                                                          });
                                                        });

                                                        Navigator.pop(context);




                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    ListTile(
                        leading: Icon(Icons.assignment_ind,
                            color: Colors.white),
                        title: Text("Altere seu CPF", style: TextStyle(color: Colors.white)),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.grey[200],
                                  content: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Adicionar Veículo!",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),

                                                )
                                            ), Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  cursorColor: Colors.black.withOpacity(0.6),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: textInputDecoration.copyWith(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    hintText: 'Digite seu novo CPF',
                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                  ),
                                                  validator: (val) => val.isEmpty ? 'CPF inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => novo_cpf = val);
                                                  }
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  cursorColor: Colors.black.withOpacity(0.6),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: textInputDecoration.copyWith(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    hintText: 'Valide sua senha',
                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                  ),
                                                  validator: (val) => val.isEmpty ? 'Senha inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => senha = val);
                                                  }
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.symmetric(horizontal: 17),
                                                  child:RaisedButton(
                                                    color: Colors.red,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                    child: Text("CANCELAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                                  child: RaisedButton(
                                                      color: Colors.red,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                      child: Text("CONFIRMAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                      onPressed: () async {
                                                        final user = Provider.of<AgileGasUser>(context, listen: false); //pega o usuario atual
                                                        final usersRef = FirebaseFirestore.instance.collection('users'); //acessa o doc dos usuarios

                                                        usersRef.get().then((snapshot){
                                                          snapshot.docs.forEach((doc){ //percorre os docs
                                                            if(doc.data()['uid'] == user.uid){ //até encontrar o do usuario atual
                                                              var result = _auth.signInWithEmailAndPassword(doc.data()['email'], senha);
                                                              if(result != null){
                                                                FirebaseFirestore.instance.collection('users').doc(user.uid).update({"cpf": novo_cpf});
                                                              } else {
                                                                Navigator.pop(context);
                                                              }
                                                            }
                                                          });
                                                        });

                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),

                        child: Text(
                            'DELETAR CONTA',
                            style: TextStyle(color: Colors.white)
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.grey[200],
                                  content: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Delete seu usário. Atenção!",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),

                                                )
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  cursorColor: Colors.black.withOpacity(0.6),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  decoration: textInputDecoration.copyWith(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                    hintText: 'Valide sua senha',
                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                  ),
                                                  validator: (val) => val.isEmpty ? 'Senha inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => senhaDel = val);
                                                  }
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.symmetric(horizontal: 17),
                                                  child:RaisedButton(
                                                    color: Colors.red,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                    child: Text("CANCELAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                                  child: RaisedButton(
                                                      color: Colors.red,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                      child: Text("CONFIRMAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                      onPressed: () async {
                                                        final despesasRef = FirebaseFirestore.instance.collection('despesas');
                                                        final carsRef = FirebaseFirestore.instance.collection('cars');
                                                        var carId;

                                                        carsRef.get().then((snapshot){ //acessa os docs dos carros
                                                          snapshot.docs.forEach((doc){ //percorre os docs dos carros
                                                            if(doc.data()['ownedByUid'] == user.uid){ //até encontrar o carro selecionado no forms
                                                              carId = doc.id; //pega o id do carro que encontrado
                                                              carsRef.doc(carId).delete(); //deleta o carro
                                                            }
                                                          });
                                                        });

                                                        despesasRef.get().then((snapshot){ //acessa os docs dos gastos
                                                          snapshot.docs.forEach((doc){
                                                            if(carId == doc.data()['idCarro']){ //encontra os dados dos carros deletados
                                                              despesasRef.doc(doc.id).delete(); //deleta os gastos
                                                            }
                                                          });
                                                        });

                                                        final usersRef = FirebaseFirestore.instance.collection('users');

                                                        usersRef.get().then((snapshot){
                                                          snapshot.docs.forEach((doc){ //percorre os docs
                                                            if(doc.data()['uid'] == user.uid){ //até encontrar o do usuario atual
                                                              _auth.deleteUser(doc.data()['email'], senhaDel);  //atualiza o email
                                                              usersRef.doc(doc.id).delete();
                                                            }
                                                          });
                                                        });

                                                        Navigator.pop(context);




                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });

                        }

                    ),
                  ],
                ),
              ),

            ],
          ),

        ),
      ),
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

class PictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(new AssetImage('images/email.png'),
        color: Colors.white);
  }
}

class PictureWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(new AssetImage('images/password.png'),
        color: Colors.white);
  }
}

class PictureWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(new AssetImage('images/username.jpg'),
        color: Colors.white);
  }
}

class PictureWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(new AssetImage('images/dot.png'), color: Colors.white);
  }
}