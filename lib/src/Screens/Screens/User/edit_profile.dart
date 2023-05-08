import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mibus/src/Screens/Screens/DashBoard/Home.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Editar perfil"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home2()));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  title:
                      Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.black,
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT,
                            msg: "No se puede cambiar el nombre");
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                  ),
                  title: Text("${FirebaseAuth.instance.currentUser!.email!}"),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.black,
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT,
                            msg: "No se puede cambiar el Correo");
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
                title: Text("5511254660"),
                trailing: Container(
                  width: 20,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: IconButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg:
                              "Presiona dos veces para cambiar numero de telfono",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black);
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
