import 'package:dbtest/Doctor_Panel/passwordupdate/forgotpassword.dart';
import 'package:dbtest/firebase_options.dart';
import 'package:dbtest/screens/patient/homeScreen_p.dart';
import 'package:dbtest/screens/signInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Doctor_Panel/pages/Doctor_Pages/docUpdate.dart';
import 'Doctor_Panel/pages/Doctor_Pages/docdashboard.dart';
import 'Doctor_Panel/pages/Doctor_Pages/dochome.dart';
import 'Doctor_Panel/pages/Doctor_Pages/doctorprofile.dart';
import 'Doctor_Panel/pages/routes.dart';
import 'Doctor_Panel/passwordupdate/Updatepass.dart';
import 'Doctor_Panel/passwordupdate/Updatepasspatient.dart';

final auth = FirebaseAuth.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => SignInScreen(), //by default this page
        MyRoutes.DocHomeR: (context) => DocHome(),
        MyRoutes.DocProfileR: (context) => docProfile(),
        MyRoutes.DocDashR: (context) => DocDashboard(),
        MyRoutes.DocUpdateR: (context) => UpdateDoc(),
        MyRoutes.Forgotpass: (context) => ForgotPassword(),
        MyRoutes.Updatepass: (context) => ChangePassword(),
        MyRoutes.Updatepasspatient: (context) => ChangePassPatient(),
      },
    );
  }
}
