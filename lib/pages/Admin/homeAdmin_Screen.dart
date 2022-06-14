import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/Admin/Subject_Screen.dart';
import 'package:e_exam_app/pages/Admin/prof_Screen.dart';
import 'package:e_exam_app/pages/login_Register/registration_page.dart';
import 'package:e_exam_app/pages/splash_screen.dart';
import 'package:e_exam_app/pages/student/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../login_Register/forgot_password_page.dart';
import '../login_Register/forgot_password_verification_page.dart';
import '../login_Register/login_page.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Department_Screen.dart';
import 'levels_Screen.dart';


class homeScreenAdmin extends StatefulWidget {
  final token;

  final name;

  final email;

  const homeScreenAdmin({ this.token, this.name, this.email}) ;
  @override
  _homeScreenAdminState createState() => _homeScreenAdminState();
}

class _homeScreenAdminState extends State<homeScreenAdmin> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  bool _isLoading = false;
  String? message;
  var sub;

  List<String> levelsListName= [];
  List<String> levelsListId= [];

  List<String> departmentsListName = [];
  List<String> departmentsListId = [];

  List<String> subjectsListName = [];
  List<String> subjectsListId = [];
  List<String> subjectsListLevel = [];
  List<String> subjectsListDepart = [];
  List<String> subjectsListProf = [];

  List<String> ProfListFirstName = [];
  List<String> ProfListLastName = [];
  List<String> ProfListId = [];
  List<String> ProfListEmail = [];

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
                "Levels",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              levelsApi();
              setState(() {
                levelsListName = [];
                levelsListId = [];
              });
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
                "Departments",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {DepartmentsApi();},
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
                "Subjects",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              SubjectsApi(widget.token);
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
                "Professor",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              ProfessorApi(widget.token);
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
                "Students",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {},
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
                  Icons.screen_lock_landscape_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  'Splash Screen',
                  style: TextStyle(
                      fontSize: 17, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SplashScreen(title: "Splash Screen")));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  'Registration Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
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
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),

    );
  }

  levelsApi() async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/levels';
    var response = await http.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {

      final data = jsonData["levels"];
      print(response.body);
      for(int i = 0 ; i< data.length; i++)
      {
        levelsListName.add(jsonData["levels"][i]["levelName"]);
        levelsListId.add(jsonData["levels"][i]["_id"]);
      }
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>levelsScreen(nameOfLevels: levelsListName,idOfLevels: levelsListId,token: widget.token,)));
        print(response.body);
        print(levelsListName);
        print(levelsListId);
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
  DepartmentsApi() async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/departments';
    var response = await http.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {

      final data = jsonData["data"];
      print(response.body);
      for(int i = 0 ; i< data.length; i++)
      {
        departmentsListName.add(jsonData["data"][i]["departmentName"]);
        departmentsListId.add(jsonData["data"][i]["_id"]);
      }
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> departmentsScreen(nameOfDepartment: departmentsListName , idOfDepartment: departmentsListId,token: widget.token,)));
        print(response.body);
        print(levelsListName);
        print(levelsListId);
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
  SubjectsApi(String token) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/subjects';
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
      for(int i = 0 ; i< data.length; i++)
      {
        subjectsListName.add(jsonData["data"][i]["subjectName"]);
        subjectsListId.add(jsonData["data"][i]["_id"]);
        subjectsListLevel.add(jsonData["data"][i]["level"]["levelName"]);
        subjectsListDepart.add(jsonData["data"][i]["department"]["departmentName"]);
        subjectsListProf.add(jsonData["data"][i]["prof"]["email"]);
      }

      print(response.body);
      setState(() {
       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>subjectsScreenAdmin(subjectsListName, subjectsListId, token,subjectsListLevel,subjectsListDepart,subjectsListProf)));
        print(response.body);
        print(subjectsListName);
        print(subjectsListId);
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
  ProfessorApi(String token) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/professors';
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
      final data = jsonData["users"];
      for(int i = 0 ; i< data.length; i++)
        {
          ProfListId.add(jsonData["users"][i]["_id"]);
          ProfListEmail.add(jsonData["users"][i]["email"]);
          ProfListFirstName.add(jsonData["users"][i]["fristName"]);
          ProfListLastName.add(jsonData["users"][i]["lastName"]);
        }


      print(response.body);
      setState(() {
     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ProfScreenAdmin(ProfEmail: ProfListEmail,ProfId: ProfListId,ProfFirstName:ProfListFirstName, ProfLastName: ProfListLastName,token: token,)));

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
