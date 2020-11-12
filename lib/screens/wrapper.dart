import 'package:agile_gas_app/models/agilegasuser.dart';
import 'package:agile_gas_app/screens/authenticate/authenticate.dart';
import 'package:agile_gas_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//essa classe é responsável verificar se o usuário está autenticado ou não. dependendo do estado de
class Wrapper extends StatelessWidget{ //autenticação a classe mostra home ou authenticate widget
  @override
  Widget build(BuildContext context){

    final user = Provider.of<AgileGasUser>(context);
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}