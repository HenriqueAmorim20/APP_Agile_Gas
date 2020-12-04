import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:agile_gas_app/shared/constants.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var latitudeData;
  var longitudeData;
  String prGasol;
  String prEtan;
  String prDie;
  String dataCad ='';
  String id;
  var currentLocation;
  var time = DateTime.now( );


  GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    getCurrentLocation();
    getMarkerData();
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      currentLocation = currloc;
    });
  }

  Future getMarkerData() async {
    FirebaseFirestore.instance.collection('postos').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }


  Future initMarker(specify, specifyId) async {
    String id = specify['geohash'];
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['position']['geopoint'].latitude,
          specify['position']['geopoint'].longitude),
      infoWindow: InfoWindow(title: specify['address'].toString(), onTap: ()async{
        showDialog(
            context: context,
            builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.grey[200],
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Posto "+specify['address'].toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),Divider(
                                color: Colors.black.withOpacity(0.5),
                              ),

                              Text("Gasolina R\$ "+specify['precogasolina'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              Text("Etanol R\$ "+specify['precoetanol'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              Text("Diesel R\$ "+specify['precodiesel'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              Text("Data de atualização: "+specify['datacad'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                child: RaisedButton(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                    child: Text("ATUALIZAR DADOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                            backgroundColor: Colors.grey[200],
                                            content: Stack(
                                              overflow: Overflow.visible,
                                              children: <Widget>[
                                                Form(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                cursorColor: Colors.black.withOpacity(0.6),
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                ),
                                                                decoration: textInputDecoration.copyWith(
                                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                                  hintText: 'Gasolina: ex.R\$4,52',
                                                                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                                ),
                                                                  validator: (val) => val.isEmpty ? 'Preço inválido.' : null, //verifica se o campo está vazio
                                                                  onChanged: (val){ //toda vez que o valor do campo mudar
                                                                    setState(() => prGasol = val); //mude o valor da variável email para o valor do campo
                                                                  }
                                                              ),
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
                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                                    hintText: 'Etanol: ex.R\$3,52',
                                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                                  ),
                                                                  validator: (val) => val.isEmpty ? 'Preço inválido.' : null, //verifica se o campo está vazio
                                                                  onChanged: (val){ //toda vez que o valor do campo mudar
                                                                    setState(() => prEtan = val); //mude o valor da variável email para o valor do campo
                                                                  }
                                                              ),
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
                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                                    hintText: 'Diesel: ex.R\$4,52',
                                                                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                                                                  ),
                                                                  validator: (val) => val.isEmpty ? 'Preço inválido.' : null, //verifica se o campo está vazio
                                                                  onChanged: (val){ //toda vez que o valor do campo mudar
                                                                    setState(() => prDie = val); //mude o valor da variável email para o valor do campo
                                                                  }
                                                              ),
                                                            ),

                                                            Container(
                                                              alignment: Alignment.bottomCenter,
                                                              margin: EdgeInsets.symmetric(horizontal: 0),
                                                              child: RaisedButton(
                                                                  color: Colors.red,
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                                                  child: Text("CONFIRMAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                                  onPressed: () async {
                                                                    String dia = time.day.toString();
                                                                    String mes  = time.month.toString();
                                                                    String ano = time.year.toString();
                                                                    dataCad = dia+'/'+mes+'/'+ano;
                                                                    if(prDie!=null&&prEtan!=null&&prGasol!=null&&dataCad!=null){
                                                                    }
                                                                    Navigator.pop(context);
                                                                    Navigator.pop(context);
                                                                  }
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  },
                                ),
                              ),

                            ],
                          ),

                      ),
                    ],
                  ),

                ),
              ],
            ),
          );
        }
        );
      }),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  Future getCurrentLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitudeData = geoposition.latitude;
      longitudeData = geoposition.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation == null
        ? Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
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
            ],
          );
  }
}
