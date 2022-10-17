import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'combineGraph.dart';

class SensorDataPage extends StatefulWidget {
  SensorDataPage({Key? key}) : super(key: key);

  @override
  State<SensorDataPage> createState() => _SensorDataPageState();
}
class _SensorDataPageState extends State<SensorDataPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Patient Ditals Data",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: context.accentColor),),
        ),
        body: Column(
              crossAxisAlignment:
                   CrossAxisAlignment.start, 
          children: [
            Row(children: 
            [
               Container(
              padding: EdgeInsets.fromLTRB(2, 10, 0, 0),
              height: 200,
              width: 175,
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => SensorsData(),
                  //   ),
                  // );
                },
                child: Card(
                  elevation: 5,
                  color: Colors.indigo,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Images/profile.png",
                                ),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center),
                          ),
                        ),
                        " sensor data page".text.xl.bold.color(Colors.white).make().p8(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 200,
              width: 175,
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => AllDoctorsPage(),
                  //   ),
                  // );
                },
                child: Card(
                  elevation: 5,
                  color: Colors.indigo,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Images/DoctorImage-01.png",
                                ),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center),
                          ),
                        ),
                        " All Doctors"
                            .text
                            .xl
                            .bold
                            .color(Colors.white)
                            .make()
                            .p8(),
                      ],
                    ),
                  ),
                ),
              ),
            ),


            ],)
          ],
          

        ),
    );
  }
}
