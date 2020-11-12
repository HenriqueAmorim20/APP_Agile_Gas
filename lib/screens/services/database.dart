import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataBaseService {
  final String uid;

  UserDataBaseService({this.uid}); //construtor recebe o uid do usuário

  //collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String cpf, int cars) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'cpf': cpf,
      'cars': cars,
    });
  }
}