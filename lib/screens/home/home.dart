import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  String nome='Henrique';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.grey[900],
        title: Image.asset('images/logo.png', color: Colors.red, height: 40, width: 130,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: new EdgeInsets.symmetric(vertical:10, horizontal: 10),
              height:300,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25),
                      topRight: const Radius.circular(25),
                      bottomLeft: const Radius.circular(25),
                      bottomRight: const Radius.circular(25)
                  )
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric( horizontal: 10),
              height:300,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25),
                      topRight: const Radius.circular(25),
                      bottomLeft: const Radius.circular(25),
                      bottomRight: const Radius.circular(25)
                  )
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(vertical:10, horizontal: 10),
              height:300,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25),
                      topRight: const Radius.circular(25),
                      bottomLeft: const Radius.circular(25),
                      bottomRight: const Radius.circular(25)
                  )
              ),
            ),
          ]
        ),

      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(45)),
        child: Drawer(
          child: Container(
            color: Colors.grey[900],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _createHeader(),
                Container(
                  color: Colors.grey[900],
                  child: new Column(
                      children: [
                        ListTile(
                            leading: Icon(Icons.directions_car_rounded, color: Colors.white),
                            title: Align(
                              child: Text('Veículos', style: TextStyle(color: Colors.white, fontSize:15 )),
                              alignment: Alignment(-1.35,0),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.attach_money_outlined, color: Colors.white),
                            title: Align(
                              child: Text('Acompanhar gastos', style: TextStyle(color: Colors.white, fontSize:15 )),
                              alignment: Alignment(-1.8,0),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }
                        ),
                        Divider(color: Colors.white.withOpacity(0.5),),

                        ListTile(
                            leading: Icon(Icons.water_damage, color: Colors.white),
                            title: Align(
                              child: Text('Cadastrar posto', style: TextStyle(color: Colors.white, fontSize:15 )),
                              alignment: Alignment(-1.5,0),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.local_gas_station, color: Colors.white),
                            title: Align(
                              child: Text('Registrar abastecimento', style: TextStyle(color: Colors.white, fontSize:15 )),
                              alignment: Alignment(-2.1,0),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }
                        ),
                        Divider(color: Colors.white.withOpacity(0.5),),
            
                        ListTile(
                            leading: Icon(Icons.article_outlined, color: Colors.white),
                            title: Align(
                              child: Text('Deixe sua sugestão!', style: TextStyle(color: Colors.white, fontSize:15 )),
                              alignment: Alignment(-1.7,0),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.settings, color: Colors.white),
                            title: Align(
                              child: Text('Configurações', style: TextStyle(color: Colors.white, fontSize:15 )),
                              alignment: Alignment(-1.5,0),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }
                        ),
                        Divider(color: Colors.white.withOpacity(0.5),),
                        SizedBox(height: 15,),
                        ListTile(
                            leading: Icon(Icons.logout, color: Colors.white),
                            title: Align(
                              child: Text('Sair', style: TextStyle(color: Colors.white, fontSize:15 )),
                              alignment: Alignment(-1.3,0),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _auth.signOut();
                            }
                        ),
                      ]
                  ),
                ),

              ],
            ),
          ),
        ),),

    );
  }
  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image:  AssetImage('images/posto.jpg'))),
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


class PictureWidget4 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/dot.png'),
        color: Colors.white, size: 20, );
  }
}