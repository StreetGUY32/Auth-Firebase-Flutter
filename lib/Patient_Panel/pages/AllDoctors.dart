import 'dart:convert';
// import 'package:fyp_app/Patient_Panel/pages/NotificationAPI.dart';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fyp_app/Patient_Panel/pages/doctorProfile.dart';
import 'package:velocity_x/velocity_x.dart';

import 'doctorProfile.dart';
//import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AllDoctorsPage extends StatefulWidget {
  AllDoctorsPage({Key? key}) : super(key: key);

  @override
  State<AllDoctorsPage> createState() => _AllDoctorsPageState();
}

class _AllDoctorsPageState extends State<AllDoctorsPage> {
  Future<String> sendNotifcation(
      String title, String BODY, String Token) async {
    Map<String, dynamic> body = {
      "to": "$Token",
      "notification": {"body": "$BODY", "title": "$title"}
    };
    final msg = jsonEncode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAASQ2TYjc:APA91bEXPXzOP2rng2Z__tV1LImGZNvp8fAdXj-Jyo7240kzyZ0Hy6OS38MEIXOabX7aHl4aUFOLyAOPiD6Ki7gKEewit-qK0RoGYMW1zOJK4O59xrH_LQq_KcA1zX8QlTw3E0g5DkdZ"
    };
    Response response = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headers,
        body: msg);
    print(response.body.toString());
    return response.body;
  }

  final TextEditingController _D_IdController = TextEditingController();
  final TextEditingController _D_AddressController = TextEditingController();
  final TextEditingController _D_EmailController = TextEditingController();
  final TextEditingController _D_PasswordController = TextEditingController();
  final TextEditingController _D_NameController = TextEditingController();
  final TextEditingController _D_PhoneNumberController =
      TextEditingController();
  final TextEditingController _D_CnicController = TextEditingController();
  final TextEditingController _D_GenderController = TextEditingController();
  void getToken() async {
    String ptoken = '';
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("Patients")
        .doc(user?.uid)
        .get();
    if (mounted)
      setState(() {
        if (vari.data() != null) {
          ptoken = vari.data()!['P_Token'].toString();
        }
      });
  }

  final CollectionReference _Doctors =
      FirebaseFirestore.instance.collection('Doctors');
  final CollectionReference _Request =
      FirebaseFirestore.instance.collection('Request');
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigo,
        title: "All doctors".text.xl4.bold.color(context.accentColor).make(),
      ),
      body: StreamBuilder(
        stream: _Doctors.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final DoctorDocs = streamSnapshot.data!.docs;
            return ListView.builder(
              itemCount: DoctorDocs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = DoctorDocs[index];
                String docId = DoctorDocs[index]['D_Id'].toString();
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DoctorProfilePage(
                          Doctordetails: DoctorDocs[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: size.height / 5.5,
                    width: context.screenWidth,
                    child: Card(
                      color: context.cardColor,
                      //margin: const EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              height: 80,
                              width: 80,
                              padding: EdgeInsets.only(left: 10, top: 10),
                              // alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/Images/defaultdoctor.jpg",
                                    ),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.center),
                              ),
                            ).pOnly(top: 10, left: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${DoctorDocs[index]["D_Name"].toString()}"
                                    .text
                                    .bold
                                    .xl2
                                    .color(context.accentColor)
                                    .make()
                                    .px8()
                                    .pOnly(top: 4),
                                "${DoctorDocs[index]["D_Email"].toString()}"
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
                                ElevatedButton(
                                  child: Text('Send Request'),
                                  onPressed: () {
                                    final recieverfcmToken =
                                        DoctorDocs[index]["D_Token"].toString();
                                    // NotificationApi().sendFcm(
                                    //     "Umair", "fcmBody", recieverfcmToken);
                                    sendNotifcation("Samreena", "fcmBody",
                                        recieverfcmToken);

                                    print("object");
                                  },
                                  //   FlutterRingtonePlayer.playNotification();
                                ),
                              ],
                            ),
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
    );
  }
}
