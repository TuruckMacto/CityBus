import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MiRuta extends StatefulWidget {
  const MiRuta({super.key});

  @override
  State<MiRuta> createState() => _MiRutaState();
}

class _MiRutaState extends State<MiRuta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
            
          icon: Icon(FontAwesomeIcons.xmark),
        ),
        title: Text("Mis Rutas"),
        centerTitle: true,
      ),
    );
  }
}
