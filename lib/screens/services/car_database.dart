import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agile_gas_app/models/car.dart';

class CarsDataBaseService {
  final String uid;
  final int nCar;

  CarsDataBaseService({this.uid, this.nCar}); //construtor recebe o uid do usuário

  //collection reference
  final CollectionReference carsCollection = FirebaseFirestore.instance.collection('cars');

  Future updateCarData(String uid, int  nCar, String marca, String modelo, String ano, String motor, String cor, String placa/*, String combustivel, double precoTotal, double precoLitro*/) async {
    return await carsCollection.doc(uid + (nCar+1).toString()).set({
      'ownedByUid': uid,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'motor': motor,
      'cor': cor,
      'placa': placa,
      /*'combustivel': combustivel,
      'precoTotal': precoTotal,
      'precoLitro': precoLitro,*/
    });
  }

  List<Car> _carListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){
      return Car(
        ownedByUid: doc.data()['ownedByUid'] ?? '',
        marca: doc.data()['marca'] ?? '',
        modelo: doc.data()['modelo'] ?? '',
        ano: doc.data()['ano'] ?? '',
        motor: doc.data()['motor'] ?? '',
        cor: doc.data()['cor'] ?? '',
        placa: doc.data()['placa'] ?? '',
        /*combustivel: doc.data()['combustivel'] ?? '',
        precoTotal: doc.data()['precoTotal'] ?? 0.0,
        precoLitro: doc.data()['precoLitro'] ?? 0.0,*/
      );
    }).toList();
  }

  Stream<List<Car>> get cars{
    return carsCollection.snapshots()
        .map(_carListFromSnapshot);
  }

}