import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var latitudeData;
  var longitudeData;

  GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    getCurrentLocation();
    getMarkerData();
    super.initState();
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection('postos').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }

  initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['position']['geopoint'].latitude,
          specify['position']['geopoint'].longitude),
      infoWindow: InfoWindow(title: specify['address'].toString()),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitudeData = geoposition.latitude;
      longitudeData = geoposition.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId('postos'),
            position: LatLng(21.1458, 79.0882),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Home'))
      ].toSet();
    }

    return Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          markers: Set<Marker>.of(markers.values),
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(latitudeData, longitudeData),
            zoom: 11.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            controller = controller;
          }),
    );
  }
}
