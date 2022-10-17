import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PatientProfile extends StatefulWidget {
  PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  String pUID = '';
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
          pUID = vari.data()!['P_Id'].toString();
          name = vari.data()!['P_Name'].toString();
          address = vari.data()!['P_Address'].toString();
          email = vari.data()!['P_Email'].toString();
          password = vari.data()!['P_Password'].toString();
          age = vari.data()!['P_Age'].toString();
          phonenumber = vari.data()!['P_PhoneNumber'].toString();
          gender = vari.data()!['P_Gender'].toString();
          cnic = vari.data()!['P_Cnic'].toString();
        }
      });
  }

  void initState() {
    super.initState();
    getData();
  }

  final TextEditingController _P_AddressController = TextEditingController();
  final TextEditingController _P_NameController = TextEditingController();
  final TextEditingController _P_PhoneNumberController =
      TextEditingController();
  final TextEditingController _P_CnicController = TextEditingController();
  final TextEditingController _P_GenderController = TextEditingController();
  final TextEditingController _P_AgeController = TextEditingController();

  Future<void> _update() async {
    _P_NameController.text = name;
    _P_AgeController.text = age;
    _P_AddressController.text = address;
    _P_GenderController.text = gender;
    _P_CnicController.text = cnic;
    _P_PhoneNumberController.text = phonenumber;

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _P_NameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _P_GenderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
                TextField(
                  controller: _P_AgeController,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: _P_PhoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                TextField(
                  controller: _P_CnicController,
                  decoration: const InputDecoration(labelText: 'Cnic'),
                ),
                TextField(
                  controller: _P_AddressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String Name = _P_NameController.text;
                    final String Gender = _P_GenderController.text;
                    final num? Age = num.tryParse(_P_AgeController.text);
                    final num? Phonenumber =
                        num.tryParse(_P_PhoneNumberController.text);
                    final num? Cnic = num.tryParse(_P_CnicController.text);
                    final String Address = _P_AddressController.text;
                    User? user = await FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection("Patients")
                          .doc(user.uid)
                          .update({
                        "P_Name": Name,
                        "P_Gender": Gender,
                        "P_Age": Age,
                        "P_PhoneNumber": Phonenumber,
                        "P_Cnic": Cnic,
                        "P_Address": Address
                      });
                      _P_NameController.text = '';
                      _P_AddressController.text = '';
                      _P_PhoneNumberController.text = '';
                      _P_AgeController.text = '';
                      _P_GenderController.text = '';
                      _P_CnicController.text = '';
                      getData();
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.indigo,
          title: "Profile".text.xl3.bold.color(context.accentColor).make(),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: context.accentColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => _update(),
                  child: Icon(
                    Icons.edit,
                    size: 26.0,
                  ),
                )),
          ]),
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/Images/patient2-01.png",
                  ),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center),
            ),
          ),
          Expanded(
              child: VxArc(
            height: 30.0,
            arcType: VxArcType.CONVEY,
            edge: VxEdge.TOP,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: context.screenWidth,
                color: context.cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Patient Name: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "$name"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Email: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "$email"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Gender: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "$gender"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Age: ".text.xl.bold.color(context.accentColor).make().p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "$age"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Cnic: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "$cnic"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                     "Phonenumber: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "$phonenumber"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                    "Address: "
                        .text
                        .xl
                        .bold
                        .color(context.accentColor)
                        .make()
                        .p8(),
                    Card(
                      elevation: 5,
                      color: context.canvasColor,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 400,
                        padding: EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "$address"
                                  .text
                                  .xl
                                  .color(context.accentColor)
                                  .make()
                                  .pOnly(top: 2, left: 4),
                            ]),
                      ),
                    ),
                  ],
                ).py32(),
              ),
            ),
          )),
        ]),
      ),
    );
  }
}
