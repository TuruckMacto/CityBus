import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mibus/src/Screens/Util/map_style.dart';

class MapsStyleController {
  void onMapCreated(GoogleMapController controllerMap) {
    controllerMap.setMapStyle(mapstyle);
  }
}
