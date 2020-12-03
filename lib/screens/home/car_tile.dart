import 'package:flutter/material.dart';
import 'package:agile_gas_app/models/car.dart';

import '../sidemenu/veiculos.dart';

class CarTile extends StatelessWidget {

  final Car car;
  CarTile({this.car});

  String mostrar_ano = 'Ano: ', mostrar_cor = 'Cor: ', mostrar_placa = 'Placa: ', mostrar_motor = 'Motor: ', mostrar_marca = 'Marca: ', mostrar_modelo = 'Modelo: ';


  @override
  Widget build(BuildContext context) {
    mostrar_ano +=car.ano;
    mostrar_cor+=car.cor;
    mostrar_placa +=car.placa;
    mostrar_motor+=car.motor;
    mostrar_modelo+=car.modelo;
    mostrar_marca+=car.marca;

    return Container(
      margin: EdgeInsets.symmetric(vertical:5, horizontal:10),
              child:RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.white, width: 0.5)
                ),
                color: Colors.black,
                child: Container(
                  child: ListTile(

                    leading: Icon(Icons.directions_car_rounded,
                      size: 40,
                      color: Colors.red,
                    ),
                    title: Text(car.modelo, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,

                    )),
                  ),
                ),
                onPressed:() async{
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Informações do Veículo"),
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
                                    Text(mostrar_placa),
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                    Text(mostrar_marca),
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                    Text(mostrar_cor),
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                    Text(mostrar_motor),
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                    Text(mostrar_ano),
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                  ],
                                ),

                              ),
                            ],
                          ),
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
                      }
                  );
                },
              ),
    );
    }
}