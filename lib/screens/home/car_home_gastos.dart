import 'package:agile_gas_app/screens/home/cars_list_gastos.dart';
import 'package:agile_gas_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:agile_gas_app/screens/services/car_database.dart';
import 'package:provider/provider.dart';
import 'package:agile_gas_app/models/car.dart';


class CarHomeGastos extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context){
    return StreamProvider<List<Car>>.value( //retorna a lista de carros no firestore presente em cars_list.dart
      value: CarsDataBaseService().cars, //stream de user_database.dart
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: CarsListGastos(),
      ),
    );
  }

}