import 'package:flutter/material.dart';
import 'package:agile_gas_app/models/car.dart';

class CarTileGastos extends StatelessWidget {

  final Car car;
  CarTileGastos({this.car});

  String mostrar_ano = 'Ano: ', mostrar_cor = 'Cor: ', mostrar_placa = 'Placa: ', mostrar_motor = 'Motor: ', mostrar_marca = 'Marca: ', mostrar_modelo = 'Modelo: ';
  String gastos_data, gastos_totais, gastos_parcial, gastos_pm, gastos_combus;

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
                    leading: Icon(Icons.attach_money_outlined,
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
                          title: Text("Gastos totais R\$1023,23"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.grey[200],
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                    Column(
                                        children: [
                                          Text("Data: ", textAlign: TextAlign.left,),
                                          Text("Total R\$256,90"),
                                          Text(" Litro R\$4,70"),
                                          Text(" Tipo: Gasolina"),
                                        ],
                                    ),
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                    Column(
                                      children: [
                                        Text("Data: ", textAlign: TextAlign.left,),
                                        Text("Total R\$206,90"),
                                        Text(" Litro R\$3,70"),
                                        Text(" Tipo: Etanol"),
                                      ],
                                    ),
                                    Divider(color: Colors.black.withOpacity(0.5)),
                                    Column(
                                      children: [
                                        Text("Data: ", textAlign: TextAlign.left,),
                                        Text("Total R\$156,90"),
                                        Text(" Litro R\$2,70"),
                                        Text(" Tipo: Diesel"),
                                      ],
                                    ),
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
                          ],
                        );
                      }
                  );
                },
              ),
    );
    }
}