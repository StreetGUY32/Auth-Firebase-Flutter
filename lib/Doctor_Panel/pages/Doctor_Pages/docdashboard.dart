import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbtest/Doctor_Panel/drawer.dart';
import 'package:dbtest/Doctor_Panel/pages/Doctor_Pages/patientprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dbtest/Doctor_Panel/pages/Doctor_Pages/patientprofile.dart';
// import 'package:dbtest/Doctor_Panel/pages/drawer.dart';
import 'package:velocity_x/velocity_x.dart%20';

import '../../../theme.dart';
//import 'package:mychatapp/pages/theme/themes.dart';

// import '../theme/themes.dart';
// import '../widgets/drawer.dart';

class DocDashboard extends StatelessWidget {
  final TextEditingController _D_IdController = TextEditingController();
  final TextEditingController _D_AddressController = TextEditingController();
  final TextEditingController _D_EmailController = TextEditingController();
  final TextEditingController _D_PasswordController = TextEditingController();
  final TextEditingController _D_NameController = TextEditingController();
  final TextEditingController _D_PhoneNumberController =
      TextEditingController();
  final TextEditingController _D_CnicController = TextEditingController();
  final TextEditingController _D_GenderController = TextEditingController();

  final CollectionReference _Patients =
      FirebaseFirestore.instance.collection('Patients');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Dashboard",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyTheme.darkbluishColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/doctordasg.webp",
                        height: 150,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                      // ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    color: Color.fromARGB(255, 120, 119, 119),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Card(
                            color: Colors.indigo.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/tpatients.png",
                                        height: 100,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                      Text(
                                        "Total Patients",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      FutureBuilder<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>(
                                          future: FirebaseFirestore.instance
                                              .collection('Patients')
                                              .get(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.docs.length
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        child: Card(
                            color: Colors.indigo.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/treatp.png",
                                        height: 100,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                      Text(
                                        "Treated Patients",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text("2",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Divider(
                    height: 30,
                    color: Color.fromARGB(255, 120, 119, 119),
                  ),
                  Container(
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "All Patients",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )
                        ]),
                  ),
                  StreamBuilder(
                    stream: _Patients.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final PatientDocs = streamSnapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: PatientDocs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                PatientDocs[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PatientProfilePage(
                                      Patientdetails: PatientDocs[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 120,
                                width: context.screenWidth,
                                child: Card(
                                  color: context.cardColor,
                                  //margin: const EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          padding: EdgeInsets.only(
                                              left: 10, top: 10),
                                          // alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/patientpp.jpg",
                                                ),
                                                fit: BoxFit.fitWidth,
                                                alignment: Alignment.center),
                                          ),
                                        ).pOnly(top: 10, left: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            "${PatientDocs[index]["P_Name"].toString()}"
                                                .text
                                                .bold
                                                .xl2
                                                .color(context.accentColor)
                                                .make()
                                                .px8(),
                                            "${PatientDocs[index]["P_Email"].toString()}"
                                                .text
                                                .bold
                                                .xl
                                                .textStyle(context.captionStyle)
                                                .make()
                                                .px8(),
                                            "Online"
                                                .text
                                                .bold
                                                .size(16)
                                                .color(Colors.green)
                                                .make()
                                                .px8(),
                                          ],
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: MyDrawer());
  }
}
