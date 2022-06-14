import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/login_Register/login_page.dart';
import 'package:e_exam_app/pages/login_Register/registration_page.dart';
import 'package:e_exam_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../login_Register/forgot_password_page.dart';
import '../login_Register/forgot_password_verification_page.dart';
import '../login_Register/login_page.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'SubjectsProf1_screen.dart';
import 'SubjectsProf_screen.dart';

class homeScreenProfessor extends StatefulWidget {
  final token;

  final name;

  final email;

  const homeScreenProfessor({ this.token, this.name, this.email}) ;
  @override
  _homeScreenProfessorState createState() => _homeScreenProfessorState();
}

class _homeScreenProfessorState extends State<homeScreenProfessor> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  bool _isLoading = false;
  String? message;
  var sub;

  List<String> LSubjectName = [];
  List<String> LSubjectId = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ])),
        ),
      ),
      body: GridView(
        padding: EdgeInsets.all(25.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 3 / 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor
                    ]),
              ),
              child: Text(
                "Subject",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              Subjects(widget.token);
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor
                    ]),
              ),
              child: Text(
                "Grade of Student",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {AllGrade(widget.token);},
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.0,
                    1.0
                  ],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.book,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Subjecs',
                  style: TextStyle(
                      fontSize: 17, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                             Subjects(widget.token)));
                },
              ),
              ListTile(
                leading: Icon(Icons.grading,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Degree for Students',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Subjects(widget.token)),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.verified_user_sharp,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Verification Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordVerificationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
  Subjects(String token) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/teacherSubjects';
    var response = await http.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {

      final data = jsonData["data"];
      print(response.body);

      for(int i = 0 ; i< data.length; i++)
      {
        LSubjectName.add(jsonData["data"][i]["subjectName"]);
        LSubjectId.add(jsonData["data"][i]["_id"]);
      }
      setState(() {
        _isLoading = false;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => subjectsProfScreen(LSubjectName, LSubjectId ,token)));
      });

    } else {
      print(response.body);
      message = jsonData["message"];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog("Error", message!, context);
        },
      );
    }
  }
  AllGrade(String token) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/teacherSubjects';
    var response = await http.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {

      final data = jsonData["data"];
      print(response.body);

      for(int i = 0 ; i< data.length; i++)
      {
        LSubjectName.add(jsonData["data"][i]["subjectName"]);
        LSubjectId.add(jsonData["data"][i]["_id"]);
      }
      setState(() {
        _isLoading = false;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => subjectsProf1Screen(LSubjectName, LSubjectId ,token)));
      });

    } else {
      print(response.body);
      message = jsonData["message"];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog("Error", message!, context);
        },
      );
    }
  }
}
