import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  String addressLocation;
  String country;
  String postalCode;
  Geoflutterfire geo = Geoflutterfire();
  bool loading;

  TextEditingController address = new TextEditingController();

  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Insira o nome do posto."),
            content: TextField(
              controller: address,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Cadastrar'),
                onPressed: () {
                  Navigator.of(context).pop(address.text.toString());
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
        infoWindow: InfoWindow(snippet: addressLocation));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GoogleMap(
            onTap: (tapped) async {
              await createAlertDialog(context).then((onValue) {
                addressLocation = onValue.toString();
              });
              getMarkers(tapped.latitude, tapped.longitude);
              GeoFirePoint point = geo.point(
                  latitude: tapped.latitude, longitude: tapped.longitude);
              await FirebaseFirestore.instance.collection('postos').add({
                'address': addressLocation,
                'position': point.data,
              });
              setState(() {});
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
