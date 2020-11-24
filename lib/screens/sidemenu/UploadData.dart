import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class UploadData extends StatefulWidget {
  final Function toggleView;
  UploadData({ this.toggleView });

  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  var formKey = GlobalKey<FormState>();

  String name;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000725),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Sugestões",style: TextStyle(color: Color(0xffffffff)),),
      ),
      body: Form(
        key: formKey,
    child:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start ,
          children: <Widget> [
            Padding(padding: EdgeInsets.only(top: 15)),




    Row(


      children: <Widget>[
        SizedBox(width: 5,),
        Expanded(
            flex: 1,
            child: Theme(
              data: ThemeData(
                hintColor: Colors.red,
              ),

              child: TextFormField(


                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Digite sua sugestão",
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
    validator: (val) => val.length == 0  ? 'Sem sugestão!' : null, //verifica se a senha é menor que 6 caracteres
    onChanged: (val) { //toda vez que o valor do campo mudar
      setState(() =>
      name = val); //mude o valor da variaǘel senha para o valor do campo
    }
              ),
            ),


        ),
        SizedBox(width: 5,),


      ],
    ),

    SizedBox(height: 10,),
        RaisedButton(
          child: const Text('Enviar'),
          color: Colors.red,
          elevation: 4.0,
          splashColor: Colors.yellow,
          onPressed: () {
             addSugestion();
          },
        ),

          ],
        ),

      ),
      ),
    );

  }
  addSugestion(){
    Map<String,dynamic> demoData = {"Sugestão": name,

    };
    CollectionReference collectionReference = Firestore.instance.collection('sugestion');
    collectionReference.add(demoData);
  }

  }





