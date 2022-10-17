// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbtest/screens/mainHome.dart';
import 'package:dbtest/screens/doctor/homeScreenD.dart';
import 'package:dbtest/screens/patient/homeScreen_p.dart';
import 'package:dbtest/screens/signUpScreen.dart';
import 'package:dbtest/reuseable_widgets/reuseable_widget.dart';
import 'package:dbtest/utils/colors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                logoWidget("assets/images/doc.png"),
                const SizedBox(
                  height: 30,
                ),
                reuseableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField("Enter Password", Icons.lock, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInsignUpButton(context, true, () async {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                      .then((value) async {
                    // print(value);

                    final userid =
                        FirebaseAuth.instance.currentUser!.uid.toString();
                    print(userid);

                    var doctors = await FirebaseFirestore.instance
                        .collection('Doctors')
                        .where('D_Id', isEqualTo: userid)
                        .get();

                    var patients = await FirebaseFirestore.instance
                        .collection('Patients')
                        .where('P_id', isEqualTo: userid)
                        .get();

                    var admins = await FirebaseFirestore.instance
                        .collection('Admins')
                        .where('uid', isEqualTo: userid)
                        .get();

                    if (patients.docs.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    } else if (doctors.docs.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreenDoc()));
                    } else if (admins.docs.isNotEmpty) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainHome()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'User not found in database, please sign up',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
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
                    }
                  }).onError((error, stackTrace) {
                    print("Error: ${error.toString()}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong, please try again',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
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
                  });
                  // User? docID = FirebaseAuth.instance.currentUser!;
                  // var doc = await FirebaseFirestore.instance
                  //     .collection('Doctor')
                  //     .doc(docID.uid)
                  //     .get();
                  // var pat = await FirebaseFirestore.instance
                  //     .collection('Patients')
                  //     .doc(docID.uid)
                  //     .get();
                  // print(pat.data());
                  // print(doc.data());
                  // if (pat.data()!['role'] == 'patient') {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreen(),
                  //     ),
                  //   );
                  // } else if (doc.data()!['role'] == 'doctor') {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreenDoc(),
                  //     ),
                  //   );
                  // } else {
                  //   print('hello');
                  // }
                }),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.indigo,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
