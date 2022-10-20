import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../routes.dart';

class UpdateDoc extends StatefulWidget {
  UpdateDoc({Key? key}) : super(key: key);

  @override
  State<UpdateDoc> createState() => _UpdateDocState();
}

class _UpdateDocState extends State<UpdateDoc> {
  bool isloading = false;
  String pUID = '';
  String name = '';
  String address = '';
  String email = '';
  String password = '';
  String gender = '';
  String age = '';
  String phonenumber = '';
  String cnic = '';
  String day = '';
  String timing = '';
  String institution = '';
  String specialization = '';
  String education = '';
  String experience = '';
  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("Doctors")
        .doc(user?.uid)
        .get();
    if (mounted)
      setState(() {
        if (vari.data() != null) {
          pUID = vari.data()!['D_Id'].toString();
          name = vari.data()!['D_Name'].toString();
          address = vari.data()!['D_Address'].toString();
          email = vari.data()!['D_Email'].toString();
          password = vari.data()!['D_Password'].toString();
          age = vari.data()!['D_Age'].toString();
          phonenumber = vari.data()!['D_PhoneNumber'].toString();
          gender = vari.data()!['D_Gender'].toString();
          cnic = vari.data()!['D_Cnic'].toString();
          day = vari.data()!['D_Days'].toString();
          timing = vari.data()!['D_Timings'].toString();
          institution = vari.data()!['D_Institution'].toString();
          specialization = vari.data()!['D_Specialization'].toString();
          education = vari.data()!['D_Education'].toString();
          experience = vari.data()!['D_Experience'].toString();
        }
      });
  }

  void initState() {
    super.initState();
    getData();
  }

  final TextEditingController D_AddressController = TextEditingController();
  final TextEditingController D_NameController = TextEditingController();
  final TextEditingController D_PhoneNumberController = TextEditingController();
  final TextEditingController D_CnicController = TextEditingController();
  final TextEditingController D_GenderController = TextEditingController();
  final TextEditingController D_AgeController = TextEditingController();
  final TextEditingController D_DayController = TextEditingController();
  final TextEditingController D_TimingController = TextEditingController();
  final TextEditingController D_InstitutionController = TextEditingController();
  final TextEditingController D_SpecializationController =
      TextEditingController();
  final TextEditingController D_EducationController = TextEditingController();
  final TextEditingController D_ExperienceController = TextEditingController();

  Future<void> _update() async {
    D_NameController.text = name;
    D_AgeController.text = age;
    D_AddressController.text = address;
    D_GenderController.text = gender;
    D_CnicController.text = cnic;
    D_PhoneNumberController.text = phonenumber;
    D_DayController.text = day;
    D_TimingController.text = timing;
    D_InstitutionController.text = institution;
    D_EducationController.text = education;
    D_SpecializationController.text = specialization;
    D_ExperienceController.text = experience;

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Padding(
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
                    controller: D_NameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: D_GenderController,
                    decoration: const InputDecoration(labelText: 'Gender'),
                  ),
                  TextField(
                    controller: D_AgeController,
                    decoration: const InputDecoration(labelText: 'Age'),
                  ),
                  TextField(
                    controller: D_PhoneNumberController,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextField(
                    controller: D_CnicController,
                    decoration: const InputDecoration(labelText: 'Cnic'),
                  ),
                  TextField(
                    controller: D_AddressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  TextField(
                    controller: D_DayController,
                    decoration: const InputDecoration(labelText: 'Days'),
                  ),
                  TextField(
                    controller: D_TimingController,
                    decoration: const InputDecoration(labelText: 'Timings'),
                  ),
                  TextField(
                    controller: D_EducationController,
                    decoration: const InputDecoration(labelText: 'Education'),
                  ),
                  TextField(
                    controller: D_InstitutionController,
                    decoration: const InputDecoration(labelText: 'Institution'),
                  ),
                  TextField(
                    controller: D_SpecializationController,
                    decoration:
                        const InputDecoration(labelText: 'Specialization'),
                  ),
                  TextField(
                    controller: D_ExperienceController,
                    decoration: const InputDecoration(labelText: 'Experience'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String Name = D_NameController.text;
                      final String Gender = D_GenderController.text;
                      final num? Age = num.tryParse(D_AgeController.text);
                      final String Phonenumber = D_PhoneNumberController.text;
                      final String Cnic = D_CnicController.text;
                      final String Address = D_AddressController.text;
                      final String Day = D_DayController.text;
                      final String Timing = D_TimingController.text;
                      final String Education = D_DayController.text;
                      final String Institution = D_DayController.text;
                      final String Specialization = D_DayController.text;
                      final String Experience = D_DayController.text;
                      User? user = await FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await FirebaseFirestore.instance
                            .collection("Doctors")
                            .doc(user.uid)
                            .update({
                          "D_Name": Name,
                          "D_Gender": Gender,
                          "D_Age": Age,
                          "D_PhoneNumber": Phonenumber,
                          "D_Cnic": Cnic,
                          "D_Address": Address,
                          "D_Day": Day,
                          "D_Timing": Timing,
                          "D_Education": Education,
                          "D_Institution": Institution,
                          "D_Specialization": Specialization,
                          "D_Experience": Experience,
                        });
                        D_NameController.text = '';
                        D_AddressController.text = '';
                        D_PhoneNumberController.text = '';
                        D_AgeController.text = '';
                        D_GenderController.text = '';
                        D_CnicController.text = '';
                        D_DayController.text = '';
                        D_TimingController.text = '';
                        D_EducationController.text = '';
                        D_InstitutionController.text = '';
                        D_SpecializationController.text = '';
                        D_ExperienceController.text = '';
                        getData();
                        Navigator.pushNamed(context, MyRoutes.DocUpdateR);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.indigo,
          title: "Personal Information"
              .text
              .xl3
              .bold
              .color(context.accentColor)
              .make(),
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
      body: isloading
          ? CircularProgressIndicator(
              color: Colors.blue,
            )
          : SafeArea(
              bottom: false,
              child: Column(children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/docgg.png",
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
                          "Doctor Name: "
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
                          "Age: "
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
                          "Days: "
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
                                    "$day"
                                        .text
                                        .xl
                                        .color(context.accentColor)
                                        .make()
                                        .pOnly(top: 2, left: 4),
                                  ]),
                            ),
                          ),
                          "Timings:"
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
                                    "$timing"
                                        .text
                                        .xl
                                        .color(context.accentColor)
                                        .make()
                                        .pOnly(top: 2, left: 4),
                                  ]),
                            ),
                          ),
                          "Education: "
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
                                    "$education"
                                        .text
                                        .xl
                                        .color(context.accentColor)
                                        .make()
                                        .pOnly(top: 2, left: 4),
                                  ]),
                            ),
                          ),
                          "Institution: "
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
                                    "$institution"
                                        .text
                                        .xl
                                        .color(context.accentColor)
                                        .make()
                                        .pOnly(top: 2, left: 4),
                                  ]),
                            ),
                          ),
                          "Specialization: "
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
                                    "$specialization"
                                        .text
                                        .xl
                                        .color(context.accentColor)
                                        .make()
                                        .pOnly(top: 2, left: 4),
                                  ]),
                            ),
                          ),
                          "Experience: "
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
                                    "$experience"
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
