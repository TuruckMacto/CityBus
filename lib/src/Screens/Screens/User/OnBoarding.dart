import 'package:flutter/material.dart';
import 'package:mibus/src/Screens/Util/colors_utils.dart';
import 'package:mibus/src/Screens/Util/reusables.dart';
import 'package:mibus/src/Screens/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/autobuss.png',
      text: "TransMovil",
      desc:
          "Con esta nueva app puedes ver el transporte publico en tiempo real, Comparte tu ruta con la comunidad, Ve los reportes de trafico.",
      bg: Colors.white,
      button: Colors.black,
    ),
    OnboardModel(

      img: 'assets/images/autobuss.png',
      text: "¿Como funciona?",
      desc:
          "Funciona gracias a la comunidad, Pueden compartir su viaje con demas usuarios que compartan la ruta, Asi cuando busques tu ruta aparecera en tiempo real",
      bg: Colors.black,
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/images/autobuss.png',
      text: "Mi Ubicacion siempre se compartira?",
      desc:
          "Tu ubicacion solo sera compartida hasta que termines el viaje ó selecciones la estacion en la que desea bajar, Este lo puede ver a la hora de seleccionar tu ruta",
      bg: Colors.black,
      button: Colors.white,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0 ? kwhite : Colors.black,
      appBar: AppBar(
        backgroundColor: currentIndex % 2 == 0 ? kwhite : Colors.black,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
            child: Text(
              "Saltar",
              style: TextStyle(
                color: currentIndex % 2 == 0 ? kblack : kwhite,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(screens[index].img),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? Colors.grey
                                      : Colors.amber,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: index % 2 == 0 ? kblack : kwhite,
                    ),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      color: index % 2 == 0 ? kblack : kwhite,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print(index);
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WelcomeScreen()));
                      }

                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: index % 2 == 0 ? Colors.black : kwhite,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          "Siguente",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: index % 2 == 0 ? kwhite : kblack),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: index % 2 == 0 ? kwhite : kblack,
                        )
                      ]),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
