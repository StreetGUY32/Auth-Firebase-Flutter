// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbtest/screens/signUpScreen.dart';
import 'package:dbtest/reuseable_widgets/reuseable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Doctor_Panel/pages/Doctor_Pages/dochome.dart';
import '../Doctor_Panel/passwordupdate/forgotpassword.dart';
import '../Patient_Panel/Patient_Dashboard.dart';

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
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: [
                logoWidget("assets/images_a/login.png"),
                const SizedBox(
                  height: 10,
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
                        .where('D_id', isEqualTo: userid)
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
                      // HandleToken().insertToken();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PatientDashboardPage()));
                    } else if (doctors.docs.isNotEmpty) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DocHome()));
                    } else if (admins.docs.isNotEmpty) {
                      print('Hello Admin');
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
                }),
                signUpOption(),
                const SizedBox(
                  height: 20,
                ),
                forgotpass(),
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
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
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

  Row forgotpass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Forgot Password? ",
          style: TextStyle(
            color: Colors.indigo,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPassword()));
          },
          child: const Text(
            "Click here",
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
