import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mibus/src/Screens/Screens/Login/Login_screen.dart';
import 'package:mibus/src/Screens/Screens/SignUp/signup_screen.dart';
import 'package:mibus/src/Screens/Util/Strings.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  


  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      child: Scaffold(
        body: FadeInUp(
          duration: Duration(milliseconds: 1400),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        Welcome,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 50),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        Comunnity,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/autobuss.png"))),
                  ),
                  Column(
                    children: <Widget>[
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          Login,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                      width: 40,
                      height: 10,
                      color: Color.fromARGB(0, 0, 0, 0),
                      child: const Text(
                        "Ó",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      elevation: 40,
                      onPressed: () {
                        SignInMethod(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Text(
                        Register,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
