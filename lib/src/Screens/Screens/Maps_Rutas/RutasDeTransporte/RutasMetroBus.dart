


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';

void RutaMetroBus(context) {
  final firestoreInstance = FirebaseFirestore.instance;
  showBottomSheet(
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          title: const Text(
            "RTP",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          actions: [
            
                  Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent),
            child: IconButton(
              onPressed: () async {
                
              },
              icon: Icon(Icons.search_outlined, size: 30,)

            ),
          ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("TraficRTP").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return  EasyContainer(
                  height: 710,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                      children: snapshot.data!.docs.map((snap) {
                    return Card(
                      child: ListTile(
                        
                        leading: (
                          Text(snap['NumRoute'],
                          
                          style: TextStyle(color: Colors.green, fontSize: 30,fontWeight: FontWeight.bold),)
                          ),
                        title: Text(
                          snap['Rutas'].toString(),
                          style: TextStyle(color: Colors.green),
                        ),
                        subtitle: Text(snap['Trafico']),

                      
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        trailing: Image(
                          image: AssetImage("assets/images/rtp.png"),
                        ),
                      ),
                      
                      elevation: 10,
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
      "Direccion": "si"
    }).then((value) {
      print(value.id);
      firestoreInstance
          .collection("TraficoRTP")
          .doc(value.id)
          .collection("Direccion")
          .add({"Direccion": "blacky", "petType": "dog", "petAge": 1});
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