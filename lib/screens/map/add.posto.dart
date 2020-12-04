import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agile_gas_app/shared/constants.dart';

import '../home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AddPosto());
  }
}

class AddPosto extends StatefulWidget {
  @override
  _AddPostoState createState() => _AddPostoState();
}

class _AddPostoState extends State<AddPosto> {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  String nomePosto;
  String country;
  String postalCode;
  Geoflutterfire geo = Geoflutterfire();
  bool loading;
  var currentLocation;
  bool sucess;

  String prGasol;
  String prEtan;
  String prDie;
  String dataCad;

  bool cadastrar;

  TextEditingController address = new TextEditingController();

  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.grey[200],
            title: Text("Cadastrar posto."),
            content: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                      cursorColor: Colors.black.withOpacity(0.6),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: textInputDecoration.copyWith(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Nome do posto: ex. Shell',
                        hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      onChanged: (val) {
                        //toda vez que o valor do campo mudar
                        setState(() => nomePosto =
                            val); //mude o valor da variável email para o valor do campo
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                      cursorColor: Colors.black.withOpacity(0.6),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: textInputDecoration.copyWith(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Preço Gasolina R\$: 4,52',
                        hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      validator: (val) => val.isEmpty
                          ? 'Preço inválido.'
                          : null, //verifica se o campo está vazio
                      onChanged: (val) {
                        //toda vez que o valor do campo mudar
                        setState(() => prGasol =
                            val); //mude o valor da variável email para o valor do campo
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                      cursorColor: Colors.black.withOpacity(0.6),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: textInputDecoration.copyWith(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Preço Etanol R\$: 3,52',
                        hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      validator: (val) => val.isEmpty
                          ? 'Preço inválido.'
                          : null, //verifica se o campo está vazio
                      onChanged: (val) {
                        //toda vez que o valor do campo mudar
                        setState(() => prEtan =
                            val); //mude o valor da variável email para o valor do campo
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                      cursorColor: Colors.black.withOpacity(0.6),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: textInputDecoration.copyWith(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Preço Diesel R\$: 3,20',
                        hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      validator: (val) => val.isEmpty
                          ? 'Preço inválido.'
                          : null, //verifica se o campo está vazio
                      onChanged: (val) {
                        //toda vez que o valor do campo mudar
                        setState(() => prDie =
                            val); //mude o valor da variável email para o valor do campo
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                      cursorColor: Colors.black.withOpacity(0.6),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: textInputDecoration.copyWith(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        hintText: 'Data: ex 02/12/2020',
                        hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      validator: (val) => val.isEmpty
                          ? 'Data inválida.'
                          : null, //verifica se o campo está vazio
                      onChanged: (val) {
                        //toda vez que o valor do campo mudar
                        setState(() => dataCad =
                            val); //mude o valor da variável email para o valor do campo
                      }),
                ),
              ]),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Cadastrar'),
                onPressed: () {
                  Navigator.of(context).pop(address.text.toString());
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: nomePosto));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = currentPosition;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    Geolocator().getCurrentPosition().then((currloc) {
      currentLocation = currloc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation == false
        ? Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                  onTap: (tapped) async {
                    await createAlertDialog(context).then((onValue) {});
                    getMarkers(tapped.latitude, tapped.longitude);
                    if (nomePosto != null &&
                        prDie != null &&
                        prEtan != null &&
                        prGasol != null &&
                        dataCad != null) {
                      sucess = true;
                    }
                    if (sucess == true) {
                      GeoFirePoint point = geo.point(
                          latitude: tapped.latitude,
                          longitude: tapped.longitude);
                      await FirebaseFirestore.instance
                          .collection('postos')
                          .add({
                        'address': nomePosto,
                        'position': point.data,
                        'precogasolina': prGasol,
                        'precoetanol': prEtan,
                        'precodiesel': prDie,
                        'datacad': dataCad,
                      });
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  mapType: MapType.hybrid,
                  compassEnabled: true,
                  trafficEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      googleMapController = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 12.0),
                  markers: Set<Marker>.of(markers.values)),
            ],
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
