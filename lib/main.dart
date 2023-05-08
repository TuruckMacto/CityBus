import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mibus/src/Screens/Screens/DashBoard/Home.dart';
import 'package:mibus/src/Screens/Screens/User/OnBoarding.dart';
import 'package:mibus/src/Screens/splashscreen.dart';
import 'package:mibus/src/Screens/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));

  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(CityBus());
}

class CityBus extends StatefulWidget {
  CityBus({Key? key}) : super(key: key);
  @override
  _CityBusState createState() => _CityBusState();
}

class _CityBusState extends State<CityBus> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'City bUS',
        debugShowCheckedModeBanner:
            false, // debug banner false that is show on corner
        theme: ThemeData(
          primarySwatch: Colors.cyan, // color to our app
        ),
        home:  MyCustomSplashScreen());
  }
}

