import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mibus/src/Screens/Screens/Login/Login_screen.dart';
import 'package:mibus/src/Screens/Screens/User/edit_profile.dart';
import 'package:mibus/src/Screens/services_Google/firebase_Services.dart';
import 'package:mibus/src/Screens/welcomeScreen.dart';
import 'package:share/share.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({super.key});

  @override
  State<SettingsProfile> createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Mi perfil",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${FirebaseAuth.instance.currentUser!.displayName}",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(" ${FirebaseAuth.instance.currentUser!.email!}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Editprofile()));
                  },
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Editar Perfil",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 30,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: const Icon(
                    FontAwesomeIcons.language,
                    color: Colors.black,
                  ),
                ),
                title: Text("Cambiar Idioma"),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.black,
                      )),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: const Icon(
                    FontAwesomeIcons.gears,
                    color: Colors.black,
                  ),
                ),
                title: Text("Configuracion"),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.black,
                      )),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: const Icon(
                    FontAwesomeIcons.google,
                    color: Colors.black,
                  ),
                ),
                title: Text("Cambiar de Cuenta"),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.black,
                      )),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: const Icon(
                    FontAwesomeIcons.headset,
                    color: Colors.black,
                  ),
                ),
                title: Text("Soporte"),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.black,
                      )),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: const Icon(
                    FontAwesomeIcons.shareNodes,
                    color: Colors.black,
                  ),
                ),
                title: Text("Compartir"),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1)),
                  child: IconButton(
                      onPressed: () {
                        Share.share(
                            "https://fontawesome.com/search?q=share&o=r");
                      },
                      icon: Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 30,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Cerrar Sesion",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
