import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mibus/src/Screens/Screens/Maps_Rutas/maps_Style.dart';
import 'package:mibus/src/Screens/Screens/User/Rutas.dart';
import 'package:mibus/src/Screens/Screens/User/settings.dart';
import 'package:mibus/src/Screens/Screens/container_home_Slider/page_1.dart';
import 'package:mibus/src/Screens/Screens/container_home_Slider/page_2.dart';
import 'package:mibus/src/Screens/Screens/container_home_Slider/page_3.dart';
import 'package:mibus/src/Screens/Util/Funciones.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Maps_Rutas/GoogleMapsRoute.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  
  late GoogleMapController mapController;
  final _controllerMap = MapsStyleController();
  late Timer timer;
  final hour = DateTime.now().hour;
  Position? position;
  PageController controllerindicator = PageController();
  LatLng? Ubicacion;
  final LatLng origin = LatLng(19.2728536, -99.1292366);
  final LatLng destination = LatLng(19.3803148, -99.0551009);

  @override
  void initState() {
    _PositionButton();
    position = position;
    Ubicacion;
    super.initState();
  }

  Future<void> _PositionButton() async {
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
    );
    setState(() {
      Ubicacion = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    String Saludo;

    if (hour < 12) {
      Saludo = "Buenos Dias";
    } else if (hour < 18) {
      Saludo = "Buenas Tardes";
    } else {
      Saludo = "Buenas Noches";
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

    

    return SafeArea(
      child: DraggableHome(
        alwaysShowLeadingAndAction: false,
        leading: LottieBuilder.asset("assets/lottie/autobus.json"),
        appBarColor: Colors.black,
        backgroundColor: Colors.black,
        fullyStretchable: false,
        centerTitle: true,
        headerExpandedHeight: 0.89,
        headerBottomBar: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Icon(Icons.minimize_outlined, color: Colors.white, size: 60,),
            SizedBox(width: 50,),
         FloatingActionButton(
        disabledElevation: 40,
        elevation: 10,
        heroTag: 'Card',
        onPressed: () {
          bottomSheet(context);
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.toc,
          color: Colors.white,
        ),
      ),
      SizedBox(width: 10,),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(color: Colors.white),
              ),
              child: Icon(
                Icons.bus_alert_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
        curvedBodyRadius: 10,
        headerWidget: Container(child: Profile(),),
        body: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                  ),
                  child: Column(
                    children: [
                      Row(
                          children: [
                            SizedBox(
                              width: 340,
                              child: MaterialButton(
                                
                                elevation: 0,
                                color: Colors.white38,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GoogleMapsRoute()));
                                },
                                child: Row(
                                 
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      color: Colors.grey,
                                    ),
                                   SizedBox(width: 20,),
                                    Text(
                                      "Busca aqui tu ruta...",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
               
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsProfile()));
                              },
                              child: CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(FirebaseAuth
                                      .instance.currentUser!.photoURL!),
                                ),
                              ),
                            )
                          ],
                        ),
                      const SizedBox(
                        height: 30,
                      ),

                      Row(children: [ Text("Favoritos", style: TextStyle(color: Colors.white, fontSize: 20),)],),
                      SizedBox(height: 10,),
                      Container(
                        height: 75, width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [ 
                            Column(
                               children: [
                                 InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 30,
                                    child: Icon(Icons.house_sharp, color: Colors.black, size: 40,)
                            )),
                            Text("Casa", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), 
                               ],
                             ),
                             Column(
                               children: [
                                 InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 30,
                                    child: Icon(Icons.work, color: Colors.black, size: 30,)
                            )),
                            Text("Trabajo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), 
                               ],
                             ),
                             Column(
                               children: [
                                 InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 30,
                                    child: Icon(Icons.add, color: Colors.black,)
                            )),
                            Text("Agregar Otro", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), 
                               ],
                             )
                          ]
                          
                        ),
                      ),
                      SizedBox(height: 30,),

                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border.all(color: Colors.white)),
                          child: Stack(
                            children: [
                              PageView(
                                controller: controllerindicator,
                                children: const [
                                  Page_intro_1(),
                                  Page_intro_2(),
                                  Page_intro_3()
                                ],
                              ),
                              Container(
                                alignment: Alignment(0, 0.9),
                                child: SmoothPageIndicator(
                                  controller: controllerindicator,
                                  count: 3,
                                  effect: CustomizableEffect(
                                      activeDotDecoration: DotDecoration(
                                          width: 10,
                                          height: 12,
                                          color: Colors.black,
                                          rotationAngle: 360,
                                          verticalOffset: -10,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          dotBorder: const DotBorder(
                                              padding: 2,
                                              width: 2,
                                              color: Colors.black)),
                                      dotDecoration: DotDecoration(
                                        width: 10,
                                        height: 12,
                                        color: Colors.amber,
                                        dotBorder: const DotBorder(
                                          padding: 2,
                                          width: 2,
                                          color: Colors.amberAccent,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      spacing: 6.0,
                                      inActiveColorOverride: (i) =>
                                          Colors.amber),
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 40,
                      ),
                    Row(
                      children: [
                          Text(

                        "AutoBus Cerca de ti",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      ],
                    ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(3)),
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                  target: LatLng(19.39068, -99.283699),
                                  zoom: 10),
                              onMapCreated: (GoogleMapController controller) {
                                mapController = controller;
                                _controllerMap
                                    .onMapCreated(mapController = controller);
                              },
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              onTap: (value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GoogleMapsRoute()));
                              },
                            ),
                          ),
                      
                        ],
                      ),
                      Text("hola", style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
        
        title: Text(
          "$Saludo",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
