import 'package:e_exam_app/pages/Admin/homeAdmin_Screen.dart';
import 'package:e_exam_app/pages/professor/home_Screen_Professor.dart';
import 'package:e_exam_app/pages/student/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e_exam_app/common/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';
import '../../common/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double _headerHeight = 200;
  Key _formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final passController = new TextEditingController();
  bool _isLoading = false;
  var message = "try again";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Signin into your account to Start Exam !',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Email', 'Enter your Email'),
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,

                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                  controller: passController,
                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordPage()),);
                                  },
                                  child: Text("Forgot your password?",
                                    style: TextStyle(color: Colors.grey,),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(
                                    context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text('Sign In'.toUpperCase(),
                                      style: TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),
                                  ),
                                  onPressed: () =>
                                  {
                                    setState(() {
                                      _isLoading = true;
                                    }),
                                    login(emailController.text,
                                        passController.text),

                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Don\'t have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrationPage()));
                                              },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme
                                                    .of(context)
                                                    .accentColor),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }


  login(String email, String password) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/sign_In';
    Map data = {
      "email": email,
      'password': password,
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(uri),
        headers: { "Accept": "application/json",
          "Content-Type": "application/json"},
        body: body
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {


      setState(() {
        _isLoading = false;
      });
      jsonData = json.decode(response.body);
      if(response.body =="{\"massge\":\"password is not corrected\"}" )
        {
          print("password is not corrected");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ThemeHelper().alartDialog(
                  "Error",
                  "password is not corrected",
                  context);
            },
          );
        }
      else {
        var token = jsonData["token"];
        var email = jsonData["user"]["email"];
        var name = jsonData["user"]["name"];
        var role = jsonData["user"]["role"];

        setState(() {
          if(role == "student") {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) =>
                    homeScreenStudent(
                        token: token, name: name, email: email)), (
                Route<dynamic> route) => false);
            print("token" + token + response.body + " email " + email);
          }
          else if(role =="professor")
            {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      homeScreenProfessor(
                          token: token, name: name, email: email)), (
                  Route<dynamic> route) => false);
            }
          else
            {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      homeScreenAdmin(
                          token: token, name: name, email: email)), (
                  Route<dynamic> route) => false);
            }

        }
        );
      }
    }
    else {
      jsonData = json.decode(response.body);
      print(response.body);
      message = jsonData["message"];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog(
              "Error",
              message,
              context);
        },
      );

    }
  }

}
