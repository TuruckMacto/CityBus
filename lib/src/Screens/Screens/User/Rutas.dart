import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:mibus/src/Screens/Screens/Maps_Rutas/GoogleMapsRoute.dart';
import 'package:mibus/src/Screens/Screens/Maps_Rutas/maps_Style.dart';
import 'package:mibus/src/Screens/Util/Funciones.dart';
import 'package:permission_handler/permission_handler.dart';

class Profile extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;

  const Profile({super.key, this.startPosition, this.endPosition});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  late GoogleMapController mapController;
  Position? positions;
  TextEditingController texController = TextEditingController();
  final _controllerMap = MapsStyleController();
  Completer<GoogleMapController> _controller = Completer();
  final LatLng _origin = LatLng(19.2728536, -99.1292366);
  final LatLng _destination = LatLng(19.3803148, -99.0551009);
  BitmapDescriptor? PinlocationIcon;
  Set<Marker> _markers = {};

  @override
  void initState() {
    _getCurrentLocation();
    positions = positions;
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.4),
            'assets/images/location.png')
        .then((onvalue) {
      PinlocationIcon = onvalue;
    });
    super.initState();
    setCustomPin();
  }

  void setCustomPin() async {
    PinlocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/autobus.png');
  }

  Future<void> _getCurrentLocation() async {
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
    );
    setState(() {
      position = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinposition = LatLng(19.39068, -99.283699);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Noticias del transporte",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      //Google Maps Destino Prueba
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _controllerMap.onMapCreated(mapController = controller);

              setState(() {
                _markers.add(
                  Marker(
                      markerId: MarkerId("Lol"),
                      position: pinposition,
                      icon: PinlocationIcon!),
                );
              });
            },
            trafficEnabled: false,
            myLocationEnabled: true,
            compassEnabled: false,
            indoorViewEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition:
                CameraPosition(bearing: 30, target: pinposition, zoom: 10),
          ),
          Positioned(
            top: 490.0,
            right: 1.0,
            child: FloatingActionButton(
              heroTag: Text('MiUbicacion'),
              onPressed: () async {
                PermissionStatus locationstatus =
                    await Permission.locationWhenInUse.request();
                if (locationstatus == PermissionStatus.granted) {
                  _getCurrentLocation();
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: positions != null
                         
                            ?LatLng(positions!.latitude,positions!.longitude) 
                            : LatLng(19.3955884,-99.1375929 ),
                        zoom: 15,
                      ),
                    ),
                  );
                }
                if (locationstatus == PermissionStatus.denied) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Necesitamos permisos de Ubicacion para poder funcionar correctamente")));
                }
                if (locationstatus == PermissionStatus.permanentlyDenied) {
                  openAppSettings();
                }
              },
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.my_location_outlined,
                size: 25,
                color: Colors.white,
              ),
              hoverColor: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}

void bottomSheet(context) {
  showModalBottomSheet(
    elevation: 30,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80),
        ),
        height: 250,
        width: 500,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(10.0),
              width: 35,
              color: Colors.black,
              height: 3.5,
            ),
            Cards(),
          ]),
        )),
  );
}

void NotificacionReporte(context) {
  showBottomSheet(
      context: context,
      builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          height: 600,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Scaffold(
            appBar: AppBar(
                title: Text("Que quieres reportar?"),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.black,
                  ),
                )),
          )));
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        InkWell(
          onTap: () {
            bottomSheet1(context);
          },
          child: const ListTile(
            leading: Icon(
              FontAwesomeIcons.route,
              color: Colors.amber,
            ),
            title: Text("Mis Viajes"),
          ),
        ),
        InkWell(
          onTap: () {
            NotificacionesTransporte(context);
          },
          child: const ListTile(
            leading: ImageIcon(
              AssetImage("assets/images/activo.png"),
              color: Colors.amber,
            ),
            title: Text("Notificaciones del Transporte"),
          ),
        ),
        InkWell(
          onTap: () {
            RutasDeTransporte(context);
          },
          child: const ListTile(
            leading: Icon(
              Icons.merge,
              color: Colors.amber,
            ),
            title: Text("Rutas del Transporte"),
          ),
        ),
        InkWell(
          onLongPress: () {
            Fluttertoast.showToast(msg: "Llamando al 911");
          },
          hoverColor: Colors.black,
          child: ListTile(
            leading: Icon(
              Icons.warning,
              color: Colors.amber,
            ),
            title: Text("Boton de panico"),
          ),
        ),
      ],
    );
  }
}

Marker AlamedaOriente = Marker(
    markerId: MarkerId("Alameda Oriente"),
    position: LatLng(19.4395916, -99.0769073),
    infoWindow: InfoWindow(
      title: "Alemeda Oriente",
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    onTap: () {
      Fluttertoast.showToast(msg: "Panzona");
    });

Marker xochimilco = Marker(
    markerId: MarkerId("Xochimilco"),
    position: LatLng(19.2594706, -99.1081866),
    infoWindow: InfoWindow(title: "Tren Ligero Xochimilco"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    onTap: () {
      Fluttertoast.showToast(msg: "Si Sirve");
    });

Marker FranciscoGoita = Marker(
    markerId: MarkerId("Francisco Goita"),
    position: LatLng(19.2611445, -99.1121429),
    infoWindow: InfoWindow(title: "Tren Ligero Xochimilco"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    onTap: () {
      Fluttertoast.showToast(msg: "Si Sirve");
    });

Marker Huichapan = Marker(
    markerId: MarkerId("Huichapan"),
    position: LatLng(19.2641066, -99.1181541),
    infoWindow: InfoWindow(title: "Tren Ligero Xochimilco"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    onTap: () {
      Fluttertoast.showToast(msg: "Si Sirve");
    });
