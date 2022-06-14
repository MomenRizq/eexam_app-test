import 'package:e_exam_app/pages/student/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_exam_app/pages/login_Register/level_screen.dart';
import 'package:e_exam_app/pages/login_Register/registration_page.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(LoginUiApp());
}

class LoginUiApp extends StatelessWidget {

  Color _primaryColor = HexColor('#2980B9');
  Color _accentColor = HexColor('##1A5276');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-exam',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),

      home: SplashScreen(title: 'E exam')
      //subjectScreen() ,
    );
  }
}


