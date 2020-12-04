import 'package:agile_gas_app/screens/map/map.page.dart';
import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/sidemenu/veiculos.dart';
import 'package:agile_gas_app/screens/sidemenu/gastos.dart';
import 'package:agile_gas_app/screens/sidemenu/cadastrar_posto.dart';
import 'package:agile_gas_app/screens/sidemenu/UploadData.dart';
import 'package:agile_gas_app/screens/sidemenu/configuracoes.dart';
import 'package:agile_gas_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:agile_gas_app/models/agilegasuser.dart';
import 'package:agile_gas_app/models/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  String nome = 'Bem-Vindo(a)';

  List<String> _combustivel = ['Gasolina', 'Etanol', 'Diesel'];
  String tipo_combustivel;

  List<String> _veiculo = [];
  String tipo_veiculo;

  String valor_litro = '';
  String total = '';
  bool checkedValue = true;

  @override
  Widget build(BuildContext context) {

    //capturar a lista de carros
    final user = Provider.of<AgileGasUser>(context, listen: false);
    final carsRef = FirebaseFirestore.instance.collection('cars');

    var tempModelo = '';
    var tempPlaca = '';
    var espaco = '';
    var tempString = '';

    _veiculo.clear();
    carsRef.get().then((snapshot){
      snapshot.docs.forEach((doc){ //percorre os docs
        if(doc.data()['ownedByUid'] == user.uid){ //até encontrar o do usuario atual
          tempModelo = doc.data()['modelo'];
          tempPlaca = doc.data()['placa'];
          espaco = ' ';
          tempString = tempModelo+espaco+tempPlaca;

          var n = _veiculo.where((v) => v == tempString).toList();

          if(n.isEmpty == true){
            _veiculo.add(tempString);
          }
        }
      });
    });
    //fim da captura da lista de carros









    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'images/logo.png',
          color: Colors.red,
          height: 30,
          width: 100,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(),
        child: new Stack(children: [
          MapPage(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: RawMaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.grey[200],
                                  content: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Form(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,

                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Text("Registre um abastecimento!",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),

                                                      )
                                                  ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                cursorColor: Colors.black
                                                    .withOpacity(0.6),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                decoration: textInputDecoration
                                                    .copyWith(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20.0),
                                                  hintText:
                                                      'Preço Total: ex.R\$249,50',
                                                  hintStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                                  validator: (val) => val.isEmpty ? 'Preço inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => total = val);
                                                  }
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                cursorColor: Colors.black
                                                    .withOpacity(0.6),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                decoration: textInputDecoration
                                                    .copyWith(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20.0),
                                                  hintText:
                                                      'Preço Litro: ex.R\$4,52',
                                                  hintStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                                  validator: (val) => val.isEmpty ? 'Preço inválido.' : null, //verifica se o campo está vazio
                                                  onChanged: (val) { //toda vez que o valor do campo mudar
                                                    setState(() => valor_litro = val);
                                                  }
                                              ),
                                            ),
                                            Container(
                                              child: Combustivel(),
                                            ),
                                            Container(
                                              //PARTE PARA IMPLEMENTAR A LISTA DE VEÍCULOS
                                              child: Veiculo(),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 17),
                                                  child: RaisedButton(
                                                    color: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical: 15),
                                                    child: Text("CANCELAR",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 0),
                                                  child: RaisedButton(
                                                      color: Colors.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0,
                                                              vertical: 15),
                                                      child: Text("CONFIRMAR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      onPressed: () async {
                                                        if(valor_litro!=null&&total!=null&&tipo_combustivel!=null&&tipo_veiculo!=null){
                                                          var time = DateTime.now();
                                                          carsRef.get().then((snapshot){
                                                            snapshot.docs.forEach((doc){ //percorre os docs dos carros
                                                              var carNomePlaca = doc.data()['modelo'] + " " + doc.data()['placa'];
                                                              if(carNomePlaca == tipo_veiculo){ //até encontrar o carro selecionado
                                                                print("AKI: " + total + valor_litro);
                                                                var carId = doc.id;
                                                                var despesasRef = FirebaseFirestore.instance.collection('despesas');
                                                                despesasRef.doc(carId+time.day.toString()+time.hour.toString()+time.second.toString()).set({
                                                                  "precoTotal": total,
                                                                  "precoLitro": valor_litro,
                                                                  "combustivel": tipo_combustivel,
                                                                  "carro": carNomePlaca,
                                                                  "idCarro": carId,
                                                                  "data": time,
                                                                });
                                                              }
                                                            }
                                                            );
                                                          });
                                                        }




                                                        Navigator.pop(context);

                                                      }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                ]
                                )
                                );
                              });
                        },
                        elevation: 2.0,
                        fillColor: Colors.black,
                        child: Icon(
                          Icons.local_gas_station,
                          color: Colors.red,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: RawMaterialButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cadastrar_posto()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.black,
                        child: Icon(
                          Icons.water_damage,
                          color: Colors.red,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
              ],
            ),
          ),
        ]),
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(45)),
        child: Drawer(
          child: Container(
            color: Colors.grey[900],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _createHeader(),
                Container(
                  color: Colors.grey[900],
                  child: new Column(children: [
                    ListTile(
                        leading: Icon(Icons.directions_car_rounded,
                            color: Colors.white),
                        title: Align(
                          child: Text('Veículos',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          alignment: Alignment(-1.35, 0),
                        ),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Veiculos()),
                          );
                        }),
                    ListTile(
                        leading: Icon(Icons.attach_money_outlined,
                            color: Colors.white),
                        title: Align(
                          child: Text('Acompanhar gastos',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          alignment: Alignment(-1.8, 0),
                        ),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Gastos()),
                          );
                        }),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    ListTile(
                        leading:
                            Icon(Icons.article_outlined, color: Colors.white),
                        title: Align(
                          child: Text('Deixe sua sugestão!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          alignment: Alignment(-1.7, 0),
                        ),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadData()),
                          );
                        }),
                    ListTile(
                        leading: Icon(Icons.settings, color: Colors.white),
                        title: Align(
                          child: Text('Configurações',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          alignment: Alignment(-1.5, 0),
                        ),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Configuracoes()),
                          );
                        }),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                        leading: Icon(Icons.logout, color: Colors.white),
                        title: Align(
                          child: Text('Sair',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          alignment: Alignment(-1.3, 0),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          _auth.signOut();
                        }),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Combustivel() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return DropdownButton(
        hint: Text('Combustível'),
        value: tipo_combustivel,
        onChanged: (newValue) {
          setState(() {
            tipo_combustivel = newValue;
          });
        },
        items: _combustivel.map((combus) {
          return DropdownMenuItem(
            child: new Text(combus),
            value: combus,
          );
        }).toList(),
      );
    });
  }

  Widget Veiculo() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return DropdownButton(
        hint: Text('Veículo'),
        value: tipo_veiculo,
        onChanged: (newValue) {
          setState(() {
            tipo_veiculo = newValue;
          });
        },
        items: _veiculo.map((vei) {
          return DropdownMenuItem(
            child: new Text(vei),
            value: vei,
          );
        }).toList(),
      );
    });
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('images/posto.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Olá, $nome!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}

class PictureWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(
      new AssetImage('images/dot.png'),
      color: Colors.white,
      size: 20,
    );
  }
}
