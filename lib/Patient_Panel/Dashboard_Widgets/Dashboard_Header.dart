import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardHeader extends StatefulWidget {
  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  String name = '';
  String address = '';
  String email = '';
  String password = '';
  String gender = '';
  String age = '';
  String phonenumber = '';
  String cnic = '';
  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("Patients")
        .doc(user?.uid)
        .get();
    if (mounted)
      setState(() {
        if (vari.data() != null) {
          name = vari.data()!['P_Name'].toString();
          address = vari.data()!['P_Address'].toString();
          email = vari.data()!['P_Email'].toString();
          password = vari.data()!['P_Password'].toString();
          age = vari.data()!['P_Age'].toString();
          phonenumber = vari.data()!['P_PhoneNumbder'].toString();
          gender = vari.data()!['P_Gender'].toString();
          cnic = vari.data()!['P_Cnic'].toString();
        }
      });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // isey text syart s ae ga
      children: [
        "Welcome $name ".text.xl4.bold.color(context.accentColor).make(),
        "Dashboard".text.xl2.make().pOnly(bottom: 12),
      ],
    );
  }
}
