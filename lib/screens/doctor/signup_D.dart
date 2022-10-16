import 'package:dbtest/reuseable_widgets/reuseable_widget.dart';
import 'package:dbtest/screens/doctor/signin_D.dart';
import 'package:dbtest/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../signInScreen.dart';

class signUpDoc extends StatefulWidget {
  const signUpDoc({Key? key}) : super(key: key);

  @override
  State<signUpDoc> createState() => _signUpDocState();
}

class _signUpDocState extends State<signUpDoc> {
  CollectionReference DocRef = FirebaseFirestore.instance.collection('doctors');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _certificationController =
      TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _timingController = TextEditingController();

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
            color: Colors.indigo,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                reuseableTextField("Enter CNIC", Icons.card_membership_outlined,
                    false, _cnicController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField("Your Education", Icons.book_online, false,
                    _educationController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField("Your Institution", Icons.school_outlined,
                    false, _institutionController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField("Your Specialty",
                    Icons.military_tech_outlined, false, _specialityController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                    "Your Experience",
                    Icons.import_contacts_outlined,
                    false,
                    _experienceController),
                const SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                    "Your Timing", Icons.timer, false, _timingController),
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
                    await DocRef.doc(UID)
                        .set({
                          'D_Name': _nameController.text,
                          'D_Email': _emailController.text,
                          'D_Password': _passwordController.text,
                          'D_Address': _addressController.text,
                          'D_Phone': _phoneController.text,
                          'D_CNIC': _cnicController.text,
                          'D_Eductaion': _educationController.text,
                          'D_Certification': _certificationController.text,
                          'D_Experience': _experienceController.text,
                          'D_Institution': _institutionController.text,
                          'D_Speciality': _specialityController.text,
                          'D_Timing': _timingController.text,
                          "uid": UID,
                          "role": "doctor",
                        })
                        .then((value) => {
                              print('doctor created'),
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
                                      builder: (context) => SignInScreen()))
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
                                builder: (context) => signUpDoc(),
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
