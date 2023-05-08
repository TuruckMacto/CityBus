import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mibus/src/Screens/Screens/Maps_Rutas/maps_Style.dart';
import 'package:mibus/src/Screens/Util/Strings.dart';
import 'package:mibus/src/Screens/Util/maps_utils.dart';

List autobus = [
  {"id": 0, "name": 'Selecciona AutoBus', 'Precio': "0.0 pesos"},
  {"id": 1, "name": 'RTP', 'Precio': "4 pesos"},
  {"id": 2, "name": 'Camion Morado', 'Precio': "4 pesos"},
  {"id": 3, "name": 'Didi', 'Precio': "60 pesos"},
  {"id": 4, "name": 'Uber', 'Precio': "50 pesos"},
];

class MapsResult extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;

  const MapsResult({super.key, this.startPosition, this.endPosition});

  @override
  State<MapsResult> createState() => _MapsResultState();
}

class _MapsResultState extends State<MapsResult> {
  late CameraPosition _initialPosition;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  int selectedAutoBusid = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialPosition = CameraPosition(
        target: LatLng(
          widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!,
        ),
        zoom: 20);
  }

  late GoogleMapController mapController;
  final _controllerMap = MapsStyleController();

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 5);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apikeyDirec,
        PointLatLng(
          widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!,
        ),
        PointLatLng(
          widget.endPosition!.geometry!.location!.lat!,
          widget.endPosition!.geometry!.location!.lng!,
        ),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId("Origen"),
        position: LatLng(
          widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!,
        ),
      ),
      Marker(
        markerId: MarkerId("Destino"),
        position: LatLng(
          widget.endPosition!.geometry!.location!.lat!,
          widget.endPosition!.geometry!.location!.lng!,
        ),
      )
    };

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Buen Viaje'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: const Icon(Icons.arrow_back_outlined),
            )),
      ),
      body: Stack(children: [
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constrainst) {
          return SizedBox(
            height: constrainst.maxHeight / 2,
            child: GoogleMap(
              polylines: Set<Polyline>.of(polylines.values),
              trafficEnabled: false,
              myLocationButtonEnabled: true,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              compassEnabled: false,
              myLocationEnabled: false,
              initialCameraPosition: _initialPosition,
              markers: Set.from(_markers),
              onMapCreated: (GoogleMapController controller) {
                Future.delayed(Duration(milliseconds: 2000), () {
                  controller.animateCamera(CameraUpdate.newLatLngBounds(
                      MapUtils.boundsFromLatLngList(
                          _markers.map((loc) => loc.position).toList()),
                      1));
                  _getPolyline();
                });
                mapController = controller;
                _controllerMap.onMapCreated(mapController = controller);
              },
            ),
          );
        }),
        DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 1,
            snapSizes: [0.5, 1],
            snap: true,

            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  controller: scrollController,
                  itemCount: autobus.length,
                  itemBuilder: (BuildContext context, int index) {
                    final autobus1 = autobus[index];
                    if (index == 0) {
                      return Padding(
                        
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          
                          children: [
                            SizedBox(
                              width: 50,
                              child: Container(
                                height: 4,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              
                            ),
                            SizedBox(height: 20,),
                            
                            Text(
                                "Posibles Rutas"),
                                Text("Comparte Tu ubicacion con otros usuarios", style: TextStyle(fontWeight: FontWeight.bold),),
                                 Text(" Asi lo pueden ver en tiempo real!", style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                      );
                    }
                    return Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            selectedAutoBusid = autobus1['id'];
                          });
                        },
                        leading: Icon(
                          FontAwesomeIcons.busSimple,
                          color: Colors.black,
                        ),
                        title: Text(autobus1["name"]),
                        trailing: Text(autobus1['Precio'].toString()),
                        selected: selectedAutoBusid == autobus1['id'],
                        selectedTileColor: Colors.grey.shade300,
                        selectedColor: Colors.blue,
                      ),
                    );
                  },
                ),
              );
            })
      ]),
    );
  }
}
