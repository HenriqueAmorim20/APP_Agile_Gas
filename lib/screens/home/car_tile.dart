import 'package:flutter/material.dart';
import 'package:agile_gas_app/models/car.dart';

import '../sidemenu/veiculos.dart';

class CarTile extends StatelessWidget {

  final Car car;
  CarTile({this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: RaisedButton(
                          child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.red,
                ),
                title: Text(car.modelo),
                subtitle: Text(car.cor),
              ),
            onPressed:() async{
              showAlertDialog(context);
            }
        )
        )
    );
    }
  
showAlertDialog(BuildContext context){
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Informações do Veiculo"),
      actions: [
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            child: Text("OK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () async {
              Navigator.pop(context);
            }
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text("DELETAR VEÍCULO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () async {
              
            }
          ),
        ),
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
}