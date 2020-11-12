import 'package:agile_gas_app/models/agilegasuser.dart';
import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:agile_gas_app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); //roda o aplicativo a partir do método construtor da classe MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AgileGasUser>.value( //coleta a informação de login/logout e passa para o wrapper
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(), //invoca lib/screens/wrapper/wrapper.dart/método construtor class Wrapper
      ),
    );
  }
}