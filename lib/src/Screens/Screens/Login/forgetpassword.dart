import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mibus/src/Screens/Util/colors_utils.dart';
import 'package:mibus/src/Screens/Util/reusables.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("000000"),
            hexStringToColor("000000"),
            hexStringToColor("ffffff"),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/password.png"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Revisa en la carpeta spam de tu correo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                reusablesTextField("Ingresa Correo", Icons.person_outline,
                    false, _emailTextController),
                const SizedBox(
                  height: 10,
                ),
                FirebaseButton(context, 'Restaurar', () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) => Navigator.of(context).pop());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
