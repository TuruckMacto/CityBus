import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mibus/src/Screens/Screens/DashBoard/Home.dart';
import 'package:mibus/src/Screens/Util/reusables.dart';
import 'package:mibus/src/Screens/services_Google/firebase_Services.dart';
import 'package:url_launcher/url_launcher.dart';

void SignInMethod(context) {

   Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "No se puede acceder al sitio";
    }
  }

  final TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  showModalBottomSheet(
    elevation: 30,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20, left: 30)),
          const Text(
            "Registrate",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          reusablesTextField("Ingresa correo", Icons.percent_outlined, false,
              _emailTextController),
          const SizedBox(
            height: 10,
          ),
          reusablesTextField('Ingresa tu contraseña', Icons.password_outlined,
              false, _passwordTextController),
          const SizedBox(
            height: 30,
          ),
          FirebaseButton(context, 'Registrarse', () async {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                elevation: 10,
                onPressed: () async {
                  await FirebaseServices().signInWithGoogle();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home2()));
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/google.png",
                    ),
                    Text("   Registrate Con Google"),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                elevation: 40,
                onPressed: () {
                  Fluttertoast.showToast(
                      gravity: ToastGravity.BOTTOM,
                      msg: "Proximamente",
                      toastLength: Toast.LENGTH_LONG,
                      textColor: Colors.white,
                      backgroundColor: Colors.black);
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/apple.png",
                    ),
                    Text("   Registrate Con Apple"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Al Registrarte Aceptas "),
                      GestureDetector(
                        onTap: (){
                          //Aqui ira la pagina que se hara despues 
                          _launchURL("www.lipsum.com");
                        },
                        child: Text("Terminos y condiciones",
                        style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
        ],
      ),
    ),
  );
 
}
