import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hospital_management/receptionist/DashBord.dart';
import 'package:hospital_management/registration/RegistrationStep.dart';
import 'package:hospital_management/utils/size.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.setSize(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.softLight,
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('images/LoginBackground.jpg'))),
            height: screenHeight * 0.7,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.06, top: screenHeight * 0.1 + 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login to your Account",
                    style: TextStyle(
                        color: Color(0xffE7EBFE),
                        fontWeight: FontWeight.w600,
                        fontSize: 32.0),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Better Care and Better Understanding.",
                    style: TextStyle(fontSize: 14.0, color: Color(0xffE7EBFE)),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.3),
            child: Align(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.white,
                ),
                height: screenHeight * 0.5,
                width: screenWidth * 0.8,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.04, right: screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.06,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "E-mail Address",
                            prefixIcon: Icon(Icons.email)),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Password", prefixIcon: Icon(Icons.lock)),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            color: Color(0xff272549),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.pink[900],
                            borderRadius: BorderRadius.circular(12.0)),
                        height: screenHeight * 0.06,
                        width: double.infinity,
                        child: RaisedButton(
                          disabledColor: Color(0xff1B34B6),
                          color: Color(0xff1B34B6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashBord(),
                                ));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an Account ?"),
                          GestureDetector(
                              child: Text("Register",
                                  style: TextStyle(
                                      color: Color(0xffFF7f2D),
                                      fontWeight: FontWeight.w600)),
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegistrationStep(),
                                    ),
                                  ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 68.0, bottom: screenHeight * 0.2),
            child: Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                  radius: 60, backgroundImage: AssetImage('images/mecare.png')),
            ),
          ),
        ],
      ),
    );
  }
}