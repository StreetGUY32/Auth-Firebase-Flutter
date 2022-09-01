import 'package:dbtest/screens/doctor/signin_D.dart';
import 'package:dbtest/screens/patient/signin_p.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  // mainAxisAlignment: MainAxisAlignment.start,
                  child: Text(
                    'We Welcome You!',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.indigo,
                  child: SizedBox(
                    width: 300,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 108,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar_d.png'),
                              radius: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Login As Doctor',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ), //Text
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'To Access All Doctor menu, Please login!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signInDoc()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.touch_app,
                                      color: Colors.indigo,
                                    ),
                                    Text('Login',
                                        style: TextStyle(color: Colors.indigo)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.indigo,
                  child: SizedBox(
                    width: 300,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 108,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/login_threedee.png'),
                              radius: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Login As Patient',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'To Access All Patient menu, Please login!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninScreen()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.touch_app,
                                      color: Colors.indigo,
                                    ),
                                    Text('Login',
                                        style: TextStyle(color: Colors.indigo)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
