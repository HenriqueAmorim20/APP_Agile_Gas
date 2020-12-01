import 'package:agile_gas_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agile_gas_app/shared/loading.dart';



class UploadData extends StatefulWidget {
  final Function toggleView;
  UploadData({ this.toggleView });

  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  var formKey = GlobalKey<FormState>();

  String sugestion = '';
  bool loading = false;



  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text('Sugestões'),
        leading: IconButton(
            iconSize: 75,
            icon: PictureWidget5(),
            onPressed: () async {
              Navigator.pop(context);
            }
        ),
      ),
      body:
      Container(
        margin: new EdgeInsets.symmetric(vertical:25, horizontal: 20),
        height:400,
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
        child:Form(
        key: formKey,
        child:  Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.start ,
            children: <Widget> [
              SizedBox(height: 45),
              Padding(padding: EdgeInsets.only(top: 15)),
              Row(
                children: <Widget>[
                  SizedBox(width: 0),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: ThemeData(
                        cursorColor: Colors.white,
                        hintColor: Colors.white,
                      ),

                      child: TextFormField(
                          maxLines: 5,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 50, horizontal:10),
                            labelText: "Digite aqui sua sugestão!",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red,width: 1)
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red,width: 1)
                            ),

                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red,width: 1)
                            ),

                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red,width: 1)
                            ),

                          ),
                          validator: (val) => val.isEmpty? 'Sem sugestão!' : null,
                          onChanged: (val) {
                            setState(() =>
                            sugestion = val);
                          }
                      ),
                    ),


                  ),
                  SizedBox(width: 0,),
                ],
              ),

              SizedBox(height: 50,),
              RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),

                  child: Text(
                      'ENVIAR SUGESTÃO',
                      style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    addSugestion();
                    showAlertDialog(context);
                  }

              ),
            ],
          ),

        ),
      ),
      ),

    );

  }
  showAlertDialog(BuildContext context)
  {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) =>Home()),
        );
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(""),
      content: Text("Sugestão enviada, obrigado!"),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
  addSugestion(){
    Map<String,dynamic> demoData = {"Sugestão": sugestion,

    };
    CollectionReference collectionReference = Firestore.instance.collection('sugestion');
    collectionReference.add(demoData);
  }

  }





class PictureWidget5 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new ImageIcon (new AssetImage('images/back.png'),
        color: Colors.red);
  }
}