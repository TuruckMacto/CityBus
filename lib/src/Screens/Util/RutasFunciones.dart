import 'package:flutter/material.dart';
import 'package:mibus/src/Screens/Util/Funciones.dart';

void MapsTrasnporte(context) {
  showBottomSheet(
      elevation: 30,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(90), topRight: Radius.circular(90))),
      backgroundColor: Colors.black,
      builder: (context) => Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            height: 710,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(padding: EdgeInsets.only(left: 90)),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.expand_more_outlined, color: Colors.black,)),
                  )
                ],
                bottomOpacity: 10,
                backgroundColor: Colors.black,
                title: Text(
                  "Posibles Rutas",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
            ),
          ));
}
