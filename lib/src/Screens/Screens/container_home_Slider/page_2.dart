import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Page_intro_2 extends StatelessWidget {
  const Page_intro_2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(-0.9, -0.5,),
      children: [
         const Text("Ya visitaste \n nuestra pagina web?", style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),),
         Align(
          alignment: Alignment(-0.9, 0.50,),
          child: ElevatedButton(
            
            onPressed: (){
              
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Ver mas" , style: TextStyle(color: Colors.white),),
                SizedBox.square(dimension: 4),
                Icon(FontAwesomeIcons.arrowRight, color: Colors.white,size: 15,)
              ],
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent
            ),
            ),
            
            ),
            
         
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/images/autobus.png",
            color: Colors.white,
            scale: 4,
          ),
        ),
      ],
    );
  }
}