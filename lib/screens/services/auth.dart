import 'package:agile_gas_app/models/agilegasuser.dart';
import 'package:agile_gas_app/screens/services/car_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agile_gas_app/screens/services/user_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//aqui serão criados os métodos que irão
class AuthService { // interagir com as formas de autenticação do firebase
  final FirebaseAuth _auth = FirebaseAuth.instance; //objeto utilizado para interagir com o firebase

  //create user object based on Firebase user
  AgileGasUser _userFromFirebaseUser(User user){
    return user != null ? AgileGasUser(uid: user.uid) : null;
  }

  AgileGasUser _newUserFromFirebaseUser(User user, String name, String cpf){
    return user != null ? AgileGasUser(uid: user.uid, name: name, cpf: cpf) : null;
  }

  //auth change user stream
  Stream<AgileGasUser> get user { //quando um usuário logar/deslogar no Firebase: retorna o objeto desse usuário
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user; //FirebaseUser deprecated
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in email/password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user; //FirebaseUser deprecated
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({"email": email});
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future changeEmail(String newEmail, String oldEmail, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: oldEmail, password: password);
    User user = result.user;
    user.updateEmail(newEmail);
  }

  //register email/password
  Future registerWithEmailAndPassword(String email, String password, String name, String cpf) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user; //FirebaseUser deprecated
      //create a new document for the new user id
      await UserDataBaseService(uid: user.uid).updateUserData(user.uid, name, cpf, email, 0);
      await CarsDataBaseService(uid: user.uid).updateCarData(user.uid, "Chevrolet", "Jeep Rebaixado", 2008, "Motor de Metal", "Vermelho", "JVC-2020", "????", 1);
      return _newUserFromFirebaseUser(user, name, cpf);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}