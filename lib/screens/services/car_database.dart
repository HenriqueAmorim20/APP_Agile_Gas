import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agile_gas_app/models/car.dart';

class CarsDataBaseService {
  final String uid;

  CarsDataBaseService({this.uid}); //construtor recebe o uid do usuário

  //collection reference
  final CollectionReference carsCollection = FirebaseFirestore.instance.collection('cars');

  Future updateCarData(String uid, String marca, String modelo, int ano, String motor, String cor, String placa, String renevam, int combustivel) async {
    return await carsCollection.doc(uid).set({
      'ownedByUid': uid,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'motor': motor,
      'cor': cor,
      'placa': placa,
      'renevam': renevam,
      'combustivel': combustivel,
    });
  }

  List<Car> _carListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){
      return Car(
        ownedByUid: doc.data()['ownedByUid'] ?? '',
        marca: doc.data()['marca'] ?? '',
        modelo: doc.data()['modelo'] ?? '',
        ano: doc.data()['ano'] ?? 0,
        motor: doc.data()['motor'] ?? '',
        cor: doc.data()['cor'] ?? '',
        placa: doc.data()['placa'] ?? '',
        renevam: doc.data()['renevam'] ?? '',
        combustivel: doc.data()['combustivel'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Car>> get cars{
    return carsCollection.snapshots()
        .map(_carListFromSnapshot);
  }

}