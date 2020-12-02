import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agile_gas_app/models/agilegasuser.dart';

class UserDataBaseService {
  final String uid;

  UserDataBaseService({this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String uid, String name, String cpf, String email, int cars) async {
    return await usersCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'cpf': cpf,
      'email': email,
      'cars': cars,
    });
  }

  List<AgileGasUser> _userFromQuerySnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return AgileGasUser(
        uid: doc.data()['uid'] ?? '',
        name: doc.data()['name'] ?? '',
        cpf: doc.data()['data'] ?? '',
        email: doc.data()['email'] ?? '',
        cars: doc.data()['cars'] ?? 0,
      );
    });
  }

  Stream<List<AgileGasUser>> get users{
    return usersCollection.snapshots()
        .map(_userFromQuerySnapshot);
  }
}