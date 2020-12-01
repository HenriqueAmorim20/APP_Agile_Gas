import "package:flutter/material.dart";
import "package:agile_gas_app/models/car.dart";
import "package:provider/provider.dart";
import "package:agile_gas_app/models/agilegasuser.dart";
import "package:agile_gas_app/screens/home/car_tile.dart";

class CarsList extends StatefulWidget {
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  @override
  Widget build(BuildContext context) {

    final cars = Provider.of<List<Car>>(context);
    final user = Provider.of<AgileGasUser>(context);
    final userCars = cars.where((c) => c.ownedByUid == user.uid).toList();

    return ListView.builder(
      itemCount: userCars.length,
      itemBuilder: (context, index) {
        return CarTile(car: userCars[index]);
      }
    );
  }
}
