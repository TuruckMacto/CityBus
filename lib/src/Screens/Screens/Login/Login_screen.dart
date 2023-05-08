import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mibus/src/Screens/Screens/DashBoard/Home.dart';
import 'package:mibus/src/Screens/Screens/Login/forgetpassword.dart';
import 'package:mibus/src/Screens/Screens/Login/reusable.dart';
import 'package:mibus/src/Screens/Screens/SignUp/signup_screen.dart';
import 'package:mibus/src/Screens/Util/Funciones.dart';
import 'package:mibus/src/Screens/Util/Strings.dart';
import 'package:mibus/src/Screens/Util/colors_utils.dart';
import 'package:mibus/src/Screens/Util/reusables.dart';
import 'package:mibus/src/Screens/services_Google/firebase_Services.dart';
import 'package:mibus/src/Screens/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    String gretting;

    if (hour < 12) {
      gretting = "Buenos Dias";
    } else if (hour < 18) {
      gretting = "Buenas Tardes";
    } else {
      gretting = "Buenas Noches";
    }
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                FadeInUp(
                    duration: const Duration(microseconds: 1400),
                    child: Container(
                      height: 400,
                      child: Image.asset("assets/images/autobus.png"),
                    )),
                const SizedBox(
                  height: 40,
                ),
                FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: Text(
                      "$gretting",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                const SizedBox(
                  height: 20,
                ),
                FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: const Text(
                      "Bienvenido de Vuelta",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 30),
                    )),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 1400),
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    delay: const Duration(milliseconds: 300),
                    child: Container(
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 30,
                        onPressed: () async {
                          await FirebaseServices().signInWithGoogle();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home2()));
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                            side: BorderSide(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/google.png",
                              width: 30,
                            ),
                            Spacer(),
                            Text("Inicia Sesion con Google",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18)),
                            Spacer(),
                          ],
                        ),
                      ),
                    )),
                FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    delay: Duration(milliseconds: 300),
                    child: Container(
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 30,
                        onPressed: () {},
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                            side: BorderSide(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/apple.png",
                              width: 30,
                            ),
                            Spacer(),
                            Text("Inicia Sesion con Apple",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18)),
                            Spacer(),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    delay: Duration(microseconds: 1200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            SignInMethod2(context);
                          },
                          child: const Text(
                              "Prefiero usar mi correo y contraseña"),
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    delay: Duration(microseconds: 1200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("No Tienes Cuenta?  "),
                        GestureDetector(
                          onTap: () {
                            SignInMethodGA(context);
                          },
                          child: Text(
                            "Registrate",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
