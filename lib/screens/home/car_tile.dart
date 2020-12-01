import 'package:flutter/material.dart';
import 'package:agile_gas_app/models/car.dart';

class CarTile extends StatelessWidget {

  final Car car;
  CarTile({this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.red,
              ),
              title: Text(car.modelo),
              subtitle: Text(car.cor),
            )
        )
    );
  }
}
