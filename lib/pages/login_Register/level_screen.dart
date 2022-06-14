import 'dart:convert';

import 'package:e_exam_app/pages/login_Register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/login_Register/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class levelScreen extends StatefulWidget {
  final firstName;

  final lastName;
  final email;
  final password;
  final role;

  const levelScreen(
      {this.firstName, this.lastName, this.email, this.password, this.role});

  @override
  _levelScreenState createState() => _levelScreenState();
}

enum Lvl { one, two, three, four }
enum Dep { general, bio }

class _levelScreenState extends State<levelScreen> {
  Lvl lvl = Lvl.one;

  Dep dep = Dep.general;
  var message = "try again";
  bool _isLoading = false;

  String levelName= "level One";

  String departName = "General";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Level and Department ",
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
      body: Column(
        children: [
          Container(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Choose your Level :",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: -7,
                        title: const Text(
                          'one',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio(
                          value: Lvl.one,
                          groupValue: lvl,
                          onChanged: (dynamic value) {
                            setState(() {
                              lvl = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: -7,
                        title: const Text(
                          'Two',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio(
                          value: Lvl.two,
                          groupValue: lvl,
                          onChanged: (dynamic value) {
                            setState(() {
                              lvl = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: -7,
                        title: const Text(
                          'Three',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio(
                          value: Lvl.three,
                          groupValue: lvl,
                          onChanged: (dynamic value) {
                            setState(() {
                              lvl = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: -7,
                        title: const Text(
                          'four',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio(
                          value: Lvl.four,
                          groupValue: lvl,
                          onChanged: (dynamic value) {
                            setState(() {
                              lvl = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),
          SizedBox(height: 8),
          Container(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Choose your Department :",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: -7,
                        title: const Text(
                          'general',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio(
                          value: Dep.general,
                          groupValue: dep,
                          onChanged: (dynamic value) {
                            setState(() {
                              dep = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: -7,
                        title: const Text(
                          'bioinformatic',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Radio(
                          value: Dep.bio,
                          groupValue: dep,
                          onChanged: (dynamic value) {
                            setState(() {
                              dep = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
          ),
          SizedBox(height: 25),
          Container(
            decoration: ThemeHelper().buttonBoxDecoration(context),
            child: ElevatedButton(
              style: ThemeHelper().buttonStyle(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text(
                  "done !".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                if (lvl == Lvl.one) {
                  levelName = "one";
                } else if (lvl == Lvl.two) {
                  levelName = "two";
                } else if (lvl == Lvl.three) {
                  levelName = "three";
                } else {
                  levelName = "four";
                }

                if (dep == Dep.general) {
                  departName = "general";
                } else {
                  departName = "bioinformatics";
                }

                setState(() {
                  _isLoading = true;
                });
                signUp(widget.firstName, widget.lastName, widget.email,
                    widget.password, widget.role , levelName, departName);
              },
            ),
          ),
        ],
      ),
    );
  }

  signUp(String first, String last, String email, String password, String role,
      String level, String Department) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/sign_Up';
    Map data = {
      "fristName": first,
      "lastName": last,
      "email": email,
      'password': password,
      'level': level,
      'department': Department,
      'role': role,

    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"}, body: body);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    jsonData = json.decode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        _isLoading = false;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ThemeHelper()
                .alartDialog("Google Plus", "You tap on one", context);
          },
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) =>LoginPage()),
            (Route<dynamic> route) => false);
      });
      print("Hello" + response.body);
    } else {
      print(response.body);
      message = jsonData["message"];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog("Error", message, context);
        },
      );

      // message = jsonData["message"] ;
      //Future.delayed(const Duration(milliseconds: 2000), () {
      //showAlertDialog(context);
      //});
    }
  }
}
