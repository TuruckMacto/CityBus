import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:mibus/src/Screens/Screens/Maps_Rutas/RutasDeTransporte/Rutas_RTP.dart';
import 'package:mibus/src/Screens/Screens/User/Rutas.dart';
import 'package:mibus/src/Screens/Screens/User/settings.dart';
import 'package:mibus/src/Screens/Util/Strings.dart';

void bottomSheet1(context) {
  showModalBottomSheet(
    elevation: 30,
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40))),
    backgroundColor: Colors.white,
    builder: (context) => Container(
        width: 460,
        height: 800,
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Mis Rutas",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20, left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SettingsProfile()));
                      },
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    )),
              )
            ],
          ),
        )),
  );
}

void bottomSheet2(context) {
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
      height: 250,
      width: 500,
      child: Stack(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            child: Center(
              child: Text("Hola me llamo diego"),
            )
          ),
        
        ],
        
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
void ReportarTrafico(context) {
  final firestoreInstance = FirebaseFirestore.instance;
  showModalBottomSheet(
    elevation: 30,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    backgroundColor: Colors.black,
    builder: (context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      height: 800,
      width: 500,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Ver estado del transporte",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                      children: snapshot.data!.docs.map((snap) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.directions_bus_outlined),
                        title: Text(
                          snap['Rutas'].toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(snap['Trafico']),
                        trailing: Image(
                          image: AssetImage("assets/images/autobus.png"),
                        ),
                      ),
                    );
                  }).toList()),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
  void updatevalue() {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("users").doc("ekNHh4MI7Xr88f1lr9A0").update({
      "characterristics": FieldValue.arrayUnion(["generous", "loving", "loyal"])
    }).then((value) {
      print("Data Added successfully");
    });
  }

  void addSubCollections() {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("users").add({
      "Rutas": "Rtp",
      "Trafico": "Grave",
      "Calles": {"street": "street 24", "city": "Lagos"}
    }).then((value) {
      print(value.id);
      firestoreInstance
          .collection("users")
          .doc(value.id)
          .collection("pets")
          .add({"petName": "blacky", "petType": "dog", "petAge": 1});
    });
  }

  void deleteDoc() {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection("users")
        .doc("ekNHh4MI7Xr88f1lr9A0")
        .delete()
        .then((_) {
      print("delete successful!");
    });
  }

  void deleteField() {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection("users")
        .doc("ekNHh4MI7Xr88f1lr9A0")
        .update({"username": FieldValue.delete()}).then(
            (value) => print("Field deleted Successfully!"));
  }

  void retrieveOnce() {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("users").get().then((value) => {
          value.docs.forEach((result) {
            print(result.data());
          })
        });
  }

  void retrieveDocUsingCondition() {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection("users")
        .where("age", isEqualTo: 24)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.id);
                print(element.data());
              })
            });
  }
}

void NotificacionesTransporte(context) {
  showModalBottomSheet(
    elevation: 30,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 800,
      width: 500,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notificaciones del Transporte",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    RutaRtp(context);
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'RTP',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/b/b1/Logo_rtp_color_cuadro.png',
                              scale: 10,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    RutaRtp(context);
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Metro Bus',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 203, 37, 25),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://www.capitalmexico.com.mx/wp-content/uploads/2019/04/49c34e20-7158-446e-b093-e876889696c1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    RutaRtp(context);
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Metro',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://www.capitalmexico.com.mx/wp-content/uploads/2019/04/48f46479-9f3e-40f6-99d5-adabdf47665d.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    RutaRtp(context);
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Tren Ligero',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://www.capitalmexico.com.mx/wp-content/uploads/2019/04/26163566-5058-406c-9e1a-f95efe0544d5.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

void RutasDeTransporte(context) {
  showModalBottomSheet(
    elevation: 30,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 800,
      width: 500,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Rutas de Transporte",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent),
              child: IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_downward_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'RTP',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/b/b1/Logo_rtp_color_cuadro.png',
                              fit: BoxFit.cover,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    RutaRtp(context);
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Metro Bus',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 203, 37, 25),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://www.capitalmexico.com.mx/wp-content/uploads/2019/04/49c34e20-7158-446e-b093-e876889696c1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    RutaRtp(context);
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Metro',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://www.capitalmexico.com.mx/wp-content/uploads/2019/04/48f46479-9f3e-40f6-99d5-adabdf47665d.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    RutaRtp(context);
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 50,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Tren Ligero',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            child: Image.network(
                              'https://www.capitalmexico.com.mx/wp-content/uploads/2019/04/26163566-5058-406c-9e1a-f95efe0544d5.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
