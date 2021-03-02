import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hospital_management/doctor/noteDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../registration/LoginPage.dart';
import '../utils/size.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  //Firebase reference
  DatabaseReference _doctordatail =
      FirebaseDatabase.instance.reference().child('doctor_detail');

  //Text Controller
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  //Globale Keys
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Variables
  bool submitButtonShow = false;
  bool shoTextField = false;

  _textField(String lableName, TextEditingController _textController,
      String Function(String) _valatidator) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        padding: EdgeInsets.all(5),
        height: screenHeight * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  color: Colors.black26,
                  offset: Offset(0, 0),
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          validator: _valatidator,
          controller: _textController,
          decoration: InputDecoration(
            enabled: shoTextField == true ? true : false,
            labelText: lableName,
            isDense: true,
          ),
        ),
      ),
    );
  }

  _notes() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetails(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
            padding: EdgeInsets.all(5),
            height: screenHeight * 0.09,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      color: Colors.black26,
                      offset: Offset(0, 0),
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "Add Your Notes",
              style: TextStyle(color: Colors.blue),
            )),
      ),
    );
  }

  _getData() {
    _doctordatail.once().then((value) {
      setState(() {
        firstNameController.text = value.value['first_name'];
        lastNameController.text = value.value['last_name'];
        statusController.text = value.value['status'];
        aboutController.text = value.value['about'];
      });
    });
  }

  _sharedPreferences() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("auth");
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.04,
          right: screenWidth * 0.04,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      _sharedPreferences();
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false);
                      });
                    }),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              CircleAvatar(
                radius: screenHeight * 0.06 + 5,
                child: Icon(Icons.supervised_user_circle_outlined),
              ),
              SizedBox(
                height: screenHeight * 0.01 + 6,
              ),
              GestureDetector(
                child: Text(
                  "Change Profile",
                  style: TextStyle(
                      fontSize: 15.3,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  print('Change profile');
                },
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: submitButtonShow == true
                      ? TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.5,
                                          bottom: screenHeight * 0.4,
                                          left: screenWidth * 0.4 + 7,
                                          right: screenWidth * 0.4 + 7),
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.2,
                                      ));
                                });
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                submitButtonShow = false;
                                shoTextField = false;
                                _doctordatail.update({
                                  'first_name': firstNameController.text,
                                  'last_name': lastNameController.text,
                                  'status': statusController.text,
                                  'about': aboutController.text
                                }).then((value) {
                                  _getData();
                                  Navigator.pop(context);
                                });
                              }
                            });
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(fontSize: 16),
                          ))
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              submitButtonShow = true;
                              shoTextField = true;
                            });
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(fontSize: 16),
                          ))),
              _textField("First Name", firstNameController,
                  ValidationBuilder().minLength(1).build()),
              _textField("Last Name", lastNameController,
                  ValidationBuilder().minLength(1).build()),
              _textField("Status", statusController,
                  ValidationBuilder().minLength(1).build()),
              _textField("About", aboutController,
                  ValidationBuilder().minLength(1).build()),
              _notes()
            ],
          ),
        ),
      ),
    );
  }
}