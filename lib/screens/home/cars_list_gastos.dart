import "package:flutter/material.dart";
import "package:agile_gas_app/models/car.dart";
import "package:provider/provider.dart";
import "package:agile_gas_app/models/agilegasuser.dart";
import "package:agile_gas_app/screens/home/car_tile_gastos.dart";

import 'cars_list_gastos.dart';

class CarsListGastos extends StatefulWidget {
  @override
  _CarsListStateGastos createState() => _CarsListStateGastos();
}

class _CarsListStateGastos extends State<CarsListGastos> {
  @override
  Widget build(BuildContext context) {

    final cars = Provider.of<List<Car>>(context);
    final user = Provider.of<AgileGasUser>(context);
    final userCars = cars.where((c) => c.ownedByUid == user.uid).toList();

    return ListView.builder(
      itemCount: userCars.length,
      itemBuilder: (context, index) {
        return CarTileGastos(car: userCars[index]);
      }
    );
  }
}
