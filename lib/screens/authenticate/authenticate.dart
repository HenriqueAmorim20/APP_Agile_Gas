import 'package:agile_gas_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/authenticate/register.dart';
//import 'package:agile_gas_app/screens/authenticate/password.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>{
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context){
    if(showSignIn == true){
      // if(){
        return SignIn(toggleView: toggleView);
     // }else{
     // return Password(toggleView: toggleView);
     // }
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
