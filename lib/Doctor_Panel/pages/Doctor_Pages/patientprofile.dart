import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PatientProfilePage extends StatefulWidget {
  final DocumentSnapshot Patientdetails;
  PatientProfilePage({Key? key, required this.Patientdetails})
      : super(key: key);
  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigo,
        title: "Profile".text.xl3.bold.color(context.accentColor).make(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/patient2-01.png",
                  ),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center),
            ),
          ),
          Expanded(
              child: VxArc(
            height: 30.0,
            arcType: VxArcType.CONVEY,
            edge: VxEdge.TOP,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: context.screenWidth,
                color: context.cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Patient Name: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${widget.Patientdetails["P_Name"].toString()}"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Email: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${widget.Patientdetails["P_Email"].toString()}"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Gender: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${widget.Patientdetails["P_Gender"].toString()}"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Age: ".text.xl.bold.color(context.accentColor).make().p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${widget.Patientdetails["P_Age"].toString()}"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Cnic: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${widget.Patientdetails["P_CNIC"].toString()}"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Phonenumber: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${widget.Patientdetails["P_PhoneNumber"].toString()}"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Address: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${widget.Patientdetails["P_Address"].toString()}"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                  ],
                ).py32(),
              ),
            ),
          )),
        ]),
      ),
    );
  }
}
