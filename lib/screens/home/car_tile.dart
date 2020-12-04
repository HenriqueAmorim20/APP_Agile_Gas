import 'package:cloud_firestore/cloud_firestore.dart';
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

    return SingleChildScrollView(child: Container(
      margin: EdgeInsets.symmetric(vertical:5, horizontal:10),
      child:RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
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
                            SizedBox(height: 20,),
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              child: RaisedButton(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: Text("DELETAR VEÍCULO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  onPressed: () async {

                                    final usersRef = FirebaseFirestore.instance.collection('users');
                                    final despesasRef = FirebaseFirestore.instance.collection('despesas');
                                    final carsRef = FirebaseFirestore.instance.collection('cars');
                                    //adicionando os dados à coleção despesas
                                    carsRef.get().then((snapshot){ //acessa os docs dos carros
                                      snapshot.docs.forEach((doc){ //percorre os docs dos carros
                                        var carNomePlaca = doc.data()['modelo'] + " " + doc.data()['placa']; //variável para buscar os carros igual o selecionado
                                        var esteCarro = car.modelo + " " + car.placa;

                                        if(carNomePlaca == esteCarro){ //até encontrar o carro selecionado no forms

                                          var carId = doc.id; //pega o id do carro que encontrado
                                          var ownedBy = doc.data()['ownedByUid'];

                                          usersRef.get().then((snapshot){ //acessa os docs dos gastos
                                            snapshot.docs.forEach((doc){
                                              if(ownedBy == doc.id){ //encontra os dados dos carros deletados
                                                int ncars = doc.data()['cars'];
                                                ncars = ncars - 1;
                                                usersRef.doc(ownedBy).update({"cars": ncars});
                                              }
                                            });
                                          });



                                          carsRef.doc(carId).delete(); //deleta o carro


                                          despesasRef.get().then((snapshot){ //acessa os docs dos gastos
                                            snapshot.docs.forEach((doc){
                                              if(carId == doc.data()['idCarro']){ //encontra os dados dos carros deletados
                                                despesasRef.doc(doc.id).delete(); //deleta os gastos
                                              }
                                            });
                                          });









                                        }
                                      });
                                    });
                                    //terminando adição dos dados à coleção despesas

                                    Navigator.pop(context);








                                  }
                              ),
                            ),
                          ],
                        ),

                      ),

                    ],
                  ),
                  actions: [

                  ],
                );
              }
          );
        },
      ),
    ),);
    }
}