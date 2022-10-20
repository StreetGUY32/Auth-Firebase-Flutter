import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbtest/Patient_Panel/Patient_Dashboard.dart';
import 'package:dbtest/Patient_Panel/pages/UpdatePassword.dart';
import 'package:dbtest/screens/signInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../functions/auth.dart';

class PatientNavigationDrawer extends StatefulWidget {
  const PatientNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<PatientNavigationDrawer> createState() =>
      _PatientNavigationDrawerState();
}

class _PatientNavigationDrawerState extends State<PatientNavigationDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //for online anf offline status
  String name = '';
  String email = '';
  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("Patients")
        .doc(user?.uid)
        .get();
    if (mounted)
      setState(() {
        Visibility(visible: true, child: CircularProgressIndicator());
        if (vari.data() != null) {
          name = vari.data()!['P_Name'].toString();
          email = vari.data()!['P_Email'].toString();
        }
      });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.canvasColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
            //Text("$name"),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      AssetImage("assets/Images/adminImage-01.png"),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "$email",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text("Home"),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const PatientDashboardPage(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.notifications_outlined),
        title: const Text("Notification"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.people_rounded),
        title: const Text("Update profile"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.password_sharp),
        title: const Text("Update Password"),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ChangePassword(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.mark_chat_read_outlined),
        title: const Text("chat history"),
        onTap: () {
          //  Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => const DashboardPage(),
          //   ),
          // );
        },
      ),
      const Divider(color: Colors.indigo),
      ListTile(
        leading: const Icon(Icons.logout_rounded),
        title: const Text("Logout"),
        onTap: () async {
          authFunction().signOut();
          print('Signed out');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'You have been signed out. See you soon!',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              backgroundColor: Colors.indigo,
              shape: Border(
                top: BorderSide(
                  color: Colors.indigo,
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Colors.indigo,
                  width: 2,
                ),
              ),
            ),
          );
        },
      ),
    ]);
  }
}
