import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management/common/chatscreen/ChatPage.dart';
import 'package:hospital_management/receptionist/PatientDatails.dart';
import 'package:hospital_management/receptionist/PatientListData.dart';
import 'package:hospital_management/utils/size.dart';

import 'DashBord.dart';

class PatientList extends StatefulWidget {
  TabController controller;
  PatientList({this.controller});
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  List<NetworkImage> profilePhoto = [
    NetworkImage(
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
    NetworkImage(
        'https://sm.askmen.com/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_gstt.jpg'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU53EcOIyxE7pOZJBvGHJGbDk39EYxvOhbdw&usqp=CAU'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5KVsWtDwcdLRc9q1P9N8leBy_zz9gfKZK1Q&usqp=CAU'),
    NetworkImage(
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
    NetworkImage(
        'https://sm.askmen.com/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_gstt.jpg'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU53EcOIyxE7pOZJBvGHJGbDk39EYxvOhbdw&usqp=CAU'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5KVsWtDwcdLRc9q1P9N8leBy_zz9gfKZK1Q&usqp=CAU'),
    NetworkImage(
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
    NetworkImage(
        'https://sm.askmen.com/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_gstt.jpg'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU53EcOIyxE7pOZJBvGHJGbDk39EYxvOhbdw&usqp=CAU'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5KVsWtDwcdLRc9q1P9N8leBy_zz9gfKZK1Q&usqp=CAU'),
    NetworkImage(
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
    NetworkImage(
        'https://sm.askmen.com/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_gstt.jpg'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU53EcOIyxE7pOZJBvGHJGbDk39EYxvOhbdw&usqp=CAU'),
    NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5KVsWtDwcdLRc9q1P9N8leBy_zz9gfKZK1Q&usqp=CAU')
  ];

  List<PatientListData> patientData = [];

  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('registration');

  @override
  void initState() {
    super.initState();
    _databaseReference.once().then((DataSnapshot snapshot) {
      var _key = snapshot.value.keys;
      var _data = snapshot.value;
      patientData.clear();
      for (var _getOneKey in _key) {
        if (_data[_getOneKey]['email_id'] != "admin@mecare.com" &&
            _data[_getOneKey]['email_id'] != "doctor@mecare.com") {
          PatientListData patientListData = new PatientListData(
            _data[_getOneKey]['first_name'],
            _data[_getOneKey]['last_name'],
            _data[_getOneKey]['user_name'],
            _data[_getOneKey]['email_id'],
            _data[_getOneKey]['number'],
            _data[_getOneKey]['address'],
            _data[_getOneKey]['date'],
            _data[_getOneKey]['user_id'],
            _data[_getOneKey]['img'],
          );
          patientData.add(patientListData);
        }
      }
      setState(() {
        print(patientData.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBord(),
                ),
                (route) => false)),
        title: Text("Patient List"),
      ),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          itemCount: patientData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(
                  top: index == 0 ? screenHeight * 0.0 : screenHeight * 0.01,
                  left: screenWidth * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(patientData[index].imgUrl),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientDatails(
                                  userName: patientData[index].userNameP,
                                  firstName: patientData[index].firstNameP,
                                  lastName: patientData[index].lastNameP,
                                  email: patientData[index].emailP,
                                  number: patientData[index].numberP,
                                  date: patientData[index].brithDateP,
                                  address: patientData[index].addressP,
                                  imgUrl: patientData[index].imgUrl,
                                ),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patientData[index].firstNameP +
                                  " " +
                                  patientData[index].lastNameP,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(patientData[index].userNameP,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.message,
                            color: Colors.blue[900],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    patientData[index].userNameP,
                                    patientData[index].userIdP,
                                    NetworkImage(patientData[index].imgUrl),
                                  ),
                                ));
                          })
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
