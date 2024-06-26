import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'ReceptionistAppointment.dart';
import 'ReceptionistChat.dart';
import 'ReceptionistDoctor.dart';
import 'ReceptionistPatient.dart';

class HomePage extends StatefulWidget {
  int indexOfTabs;
  HomePage(this.indexOfTabs);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController navcontroller;

  @override
  void initState() {
    navcontroller = TabController(length: 4, vsync: this);
    navcontroller.index = widget.indexOfTabs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: navcontroller,
            children: [
              ReceptionistAppointment(),
              ReceptionistChat(),
              ReceptionistDoctor(),
              ReceptionistPatient(),
            ],
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
        CustomNavigationBar(
          currentIndex: navcontroller.index,
          iconSize: 30.0,
          selectedColor: Color(0xff0c18fb),
          strokeColor: Color(0x300c18fb),
          unSelectedColor: Colors.grey[600],
          backgroundColor: Colors.white,
          items: [
            CustomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded)),
            CustomNavigationBarItem(
              icon: Icon(Icons.chat),
            ),
            CustomNavigationBarItem(icon: Icon(Icons.local_hospital_outlined)),
            CustomNavigationBarItem(icon: Icon(Icons.supervised_user_circle)),
          ],
          onTap: (index) {
            setState(() {
              navcontroller.index = index;
            });
          },
        )
      ],
    ));
  }
}
