import 'package:cloud_firestore/cloud_firestore.dart';
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

    String precoTotal = '';
    String precoLitro = '';
    String tipo = '';
    String data = '';


    var gastosRef = FirebaseFirestore.instance.collection('despesas');
    var carsRef = FirebaseFirestore.instance.collection('cars');

    carsRef.get().then((snapshot){
      snapshot.docs.forEach((doc){ //percorre os docs dos carros
        var tipo_veiculo = doc.data()['modelo'] + " " + doc.data()['placa'];
        var carNomePlaca = car.modelo + " " + car.placa;

        if(carNomePlaca == tipo_veiculo){ //até encontrar o carro selecionado

          var carId = doc.id;


          gastosRef.get().then((snapshot){
            snapshot.docs.forEach((doc){ //percorre os docs dos carros
              if(doc.data()['idCarro'] == carId){ //até encontrar o carro selecionado
                precoTotal = doc.data()['precoTotal'];
                precoLitro = doc.data()['precoLitro'];
                tipo = doc.data()['combustivel'];
              }
            }
            );
          });



        }
      }
      );
    });






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
                          title: Text("Último abastecimento."),
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
                                          Text("Total: R\$$precoTotal", style: TextStyle(fontSize: 20)),
                                          Text("Preço litro: R\$$precoLitro", style: TextStyle(fontSize: 20)),
                                          Text("Combustível: $tipo", style: TextStyle(fontSize: 20)),
                                        ],
                                    ),],
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