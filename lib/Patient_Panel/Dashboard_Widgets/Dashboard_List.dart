import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbtest/Patient_Panel/pages/AllDoctors.dart';
import 'package:dbtest/Patient_Panel/pages/Patientprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:fyp_app/Patient_Panel/pages/AllDoctors.dart';
// import 'package:fyp_app/Patient_Panel/pages/Patientprofile.dart';
// import 'package:fyp_app/Patient_Panel/pages/combineGraph.dart';
import 'package:velocity_x/velocity_x.dart';

import '../pages/SensorDataPage.dart';

class DashboardList extends StatefulWidget {
  const DashboardList({Key? key}) : super(key: key);

  @override
  State<DashboardList> createState() => _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  // List? Allrequest;

  // void getdata() {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   FirebaseFirestore.instance
  //       .collection("Request")
  //       .where('D_Id', isEqualTo: 'aa')
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       Allrequest = value.docs;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 200,
              width: 175,
              child: InkWell(
                onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PatientProfile(),
                      ),
                    );
                 // getdata();
                },
                child: Card(
                  elevation: 5,
                  color: Colors.indigo,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Images/profile.png",
                                ),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center),
                          ),
                        ),
                         " Profile".text.xl.bold.color(Colors.white).make().p8(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 200,
              width: 175,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AllDoctorsPage(),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  color: Colors.indigo,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Images/DoctorImage-01.png",
                                ),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center),
                          ),
                        ),
                        " All Doctors"
                            .text
                            .xl
                            .bold
                            .color(Colors.white)
                            .make()
                            .p8(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 200,
              width: 175,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SensorDataPage(),
                  ));
                },
                child: Card(
                  elevation: 5,
                  color: Colors.indigo,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Images/adminImage-01.png",
                                ),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center),
                          ),
                        ),
                        " Check your Vitals"
                            .text
                            .xl
                            .bold
                            .color(Colors.white)
                            .make()
                            .p8(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 200,
              width: 175,
              child: InkWell(
                onTap: () async {
                  DatabaseReference ref =
                      FirebaseDatabase.instance.ref("users/123");
                  await ref.set({
                    "name": "John",
                    "age": 18,
                    "address": {"line1": "100 Mountain View"}
                  });
                },
                child: Card(
                  elevation: 5,
                  color: Colors.indigo,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Images/Request-01.png",
                                ),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center),
                          ),
                        ),
                        "Request Doctor"
                            .text
                            .xl
                            .bold
                            .color(Colors.white)
                            .make()
                            .p8(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
