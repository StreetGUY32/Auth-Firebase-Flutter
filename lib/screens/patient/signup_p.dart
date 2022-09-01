import 'package:dbtest/reuseable_widgets/reuseable_widget.dart';
import 'package:dbtest/screens/patient/homeScreen_p.dart';
import 'package:dbtest/screens/patient/signin_p.dart';
import 'package:dbtest/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  CollectionReference patientRef =
      FirebaseFirestore.instance.collection('Patients');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("FFFFFF"),
            hexStringToColor("0000FF"),
            hexStringToColor("0D98BA"),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                    "Enter Name", Icons.person_outline, false, _nameController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                    'Enter Email', Icons.mail_outline, false, _emailController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                    "Enter Address", Icons.home, false, _addressController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField("Enter Phone", Icons.phone_android, false,
                    _phoneController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                    "Enter Age", Icons.calendar_today, false, _ageController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField("Enter CNIC", Icons.card_membership_outlined,
                    false, _cnicController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                    "Gender", Icons.person, false, _genderController),
                const SizedBox(
                  height: 20,
                ),
                signInsignUpButton(
                  context,
                  false,
                  () async {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                    String UID = FirebaseAuth.instance.currentUser!.uid;
                    await patientRef
                        .doc(UID)
                        .set({
                          'P_Name': _nameController.text,
                          'P_Email': _emailController.text,
                          'P_Password': _passwordController.text,
                          'P_Address': _addressController.text,
                          'P_Phone': _phoneController.text,
                          'P_Age': _ageController.text,
                          'P_CNIC': _cnicController.text,
                          'P_Gender': _genderController.text,
                          "uid": UID,
                          "role": "patient",
                        })
                        .then((value) => {
                              print('user created'),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Sign Up Successful, Please Login',
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
                              ),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SigninScreen()))
                            })
                        .onError(
                          (error, stackTrace) => {
                            print(
                                'Error: ${error.toString()} StackTrace: ${stackTrace.toString()}'),
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Sign Up Failed, Please Try Again',
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
                            ),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SigninScreen(),
                              ),
                            )
                          },
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
