import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management/common/chatscreen/ChatPage.dart';
import 'package:hospital_management/common/doctorscreen/doctorDatailData.dart';
import 'package:hospital_management/patient/AppointmentPage.dart';
import 'package:hospital_management/receptionist/DashBord.dart';
import 'package:hospital_management/receptionist/PatientList.dart';

import 'package:hospital_management/utils/size.dart';

import '../../utils/size.dart';
import 'doctorDatailData.dart';

class DoctorDatailPage extends StatefulWidget {
  String nameOfDoctor;
  NetworkImage doctorPhoto;
  DoctorDatailPage({this.doctorPhoto, this.nameOfDoctor});
  @override
  _DoctorDatailPageState createState() => _DoctorDatailPageState();
}

class _DoctorDatailPageState extends State<DoctorDatailPage> {
  List<DoctorDatailData> doctorDatailList = [];

  //firebase
  DatabaseReference _doctorreference =
      FirebaseDatabase.instance.reference().child("doctor_detail");
  DatabaseReference _notes =
      FirebaseDatabase.instance.reference().child("notes");
  static String doctorUserName = "";
  static String doctroFirstName = "";
  static String doctroLastName = "";
  static String doctorStstus = "";
  static String doctorabout = "";
  static String doctorUserId = "";
  static String imgUrl =
      "https://cdn0.iconfinder.com/data/icons/seo-web-optimization-3/24/148-512.png";
  @override
  void initState() {
    super.initState();
    doctorDatailList.clear();
    _doctorreference.once().then((DataSnapshot snap) {
      DoctorDatailData doctorDatailData = new DoctorDatailData(
          snap.value['user_name'],
          snap.value['first_name'],
          snap.value['last_name'],
          snap.value['status'],
          snap.value['about'],
          snap.value['user_id'],
          snap.value['img']);
      doctorDatailList.add(doctorDatailData);
      setState(() {
        doctorUserName = doctorDatailList[0].userNameP;
        doctroFirstName = doctorDatailList[0].firstNameP;
        doctroLastName = doctorDatailList[0].lastNameP;
        doctorStstus = doctorDatailList[0].ststusP;
        doctorabout = doctorDatailList[0].aboutP;
        doctorUserId = doctorDatailList[0].userIdP;
        imgUrl = doctorDatailList[0].imgUrlP;
      });
    });
  }

  Widget _notesdata(var data) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[100], borderRadius: BorderRadius.circular(11)),
      margin: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          bottom: screenHeight * 0.01),
      child: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(data['note'])],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: screenHeight * 0.3 + 50,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/doctorProfile.png'),
                  fit: BoxFit.fill)),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.03,
          ),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                if (FirebaseAuth.instance.currentUser.email ==
                    "admin@mecare.com") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashBord(),
                      ),
                      (route) => false);
                } else {
                  Navigator.pop(context);
                }
              }),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.3 + 10),
          child: Container(
            height: screenHeight * 0.7,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.0),
                    topRight: Radius.circular(45.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight * 0.04, left: screenWidth * 0.05),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 34.0, backgroundImage: NetworkImage(imgUrl)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.03),
                            child: Text(doctroFirstName + " " + doctroLastName,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.03),
                            child: Text(doctorStstus,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.message),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                          doctorUserName,
                                          doctorUserId,
                                          NetworkImage(imgUrl),
                                        ),
                                      ));
                                },
                                color: Colors.orange[400],
                                disabledColor: Colors.orange[400],
                              ),
                              FirebaseAuth.instance.currentUser.email ==
                                      "admin@mecare.com"
                                  ? IconButton(
                                      icon: Icon(Icons
                                          .supervised_user_circle_outlined),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PatientList(),
                                            ));
                                      },
                                      color: Colors.orange[400],
                                      disabledColor: Colors.orange[400],
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.calendar_today_rounded),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentPage(
                                              doctorPhoto: NetworkImage(imgUrl),
                                              doctorName: doctroFirstName +
                                                  " " +
                                                  doctroLastName,
                                            ),
                                          )),
                                      color: Colors.blue[800],
                                      disabledColor: Colors.blue[800],
                                    ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.05, bottom: screenHeight * 0.02),
                  child: Text(
                    "About Doctor",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      bottom: screenHeight * 0.02 - 4),
                  child: Text(
                    doctorabout,
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        height: 1.4),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.05, bottom: screenHeight * 0.01),
                  child: Text(
                    "Notes",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: Container(
                      height: screenHeight * 0.2,
                      child: FirebaseAnimatedList(
                        query: _notes,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          return _notesdata(snapshot.value);
                        },
                      )),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
