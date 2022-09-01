import 'package:dbtest/reuseable_widgets/reuseable_widget.dart';
import 'package:dbtest/screens/doctor/homeScreenD.dart';
import 'package:dbtest/screens/doctor/signup_D.dart';
import 'package:dbtest/utils/colors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signInDoc extends StatefulWidget {
  const signInDoc({Key? key}) : super(key: key);

  @override
  State<signInDoc> createState() => _signInDocState();
}

class _signInDocState extends State<signInDoc> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                logoWidget("assets/images/logo.png"),
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
                signInsignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    // print(FirebaseAuth.instance.currentUser);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreenDoc()));
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
            color: Colors.white70,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => signUpDoc()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
