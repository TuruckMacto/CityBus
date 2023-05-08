import 'package:flutter/material.dart';

const String apikeyDirec = "AIzaSyCabjK2nlWakPgakipzk0ehGBEe2Lpik44";
const String apiKey = "AIzaSyAkIzAy4NxbjNjP4R9Lj11ItLUoiybKvfk";
const String apliKeyMap = "AIzaSyC5uVSs8X5slvkF4q9v6XsLuB_dknUDMAc";
const String buscaRuta = "Busca tu ruta Aqui";
const String Register = "Registrate";
const String Login = "Iniciar Sesion";
const String NoAccunt = "No Tienes Cuenta?  ";
const String Welcome = "Bienvenido  ";
const String Comunnity = "Forma parte de la comunidad  ";

class LocationListtitle extends StatelessWidget {
  const LocationListtitle({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);
  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: Icon(
            Icons.my_location_outlined,
          ),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class LocaitionModel {
  final double latitude;
  final double longitude;
  const LocaitionModel({required this.latitude, required this.longitude});
}
