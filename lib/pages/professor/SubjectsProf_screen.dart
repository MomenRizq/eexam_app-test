import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/professor/cardExamsProf_screen.dart';
import 'package:e_exam_app/pages/student/cardExam_screen.dart';
import 'package:e_exam_app/pages/splash_screen.dart';
import 'package:e_exam_app/pages/professor/addQuestion.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class subjectsProfScreen extends StatefulWidget {
  final List SubjectsName;
  final List SubjectsId;
  final token;

  const subjectsProfScreen(this.SubjectsName, this.SubjectsId, this.token);

  @override
  State<subjectsProfScreen> createState() => _subjectsProfScreenState();
}

class _subjectsProfScreenState extends State<subjectsProfScreen> {
  String? id;

  bool _isLoading = false;

  List<String> idExam = [];
  List<String> nameOfExam = [];
  List<int> timer = [];
  List<int> Score = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subject",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
            setState(() {
             widget.SubjectsId.clear();
             widget.SubjectsName.clear();
            });
          },
        ) ,
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
            crossAxisSpacing: 13,
            mainAxisSpacing: 13,
          ),
          children: <Widget>[
            for (int i = 0; i < widget.SubjectsName.length; i++)
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
                    widget.SubjectsName[i],
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  id = widget.SubjectsId[i];
                  ShowEx_api(id!, widget.token);
                  print(widget.SubjectsName.toString());
                },
              )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBottomSheet(widget.SubjectsName , widget.SubjectsId , widget.token);
        },
        child: Icon(Icons.add),
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void showAddBottomSheet(List SubjectsName , List SubjectId , token) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return addQuestion(SubjectsId: SubjectId , SubjectsName:SubjectsName , token: token,);
        });
  }
  ShowEx_api(String id, String token) async {
    var jsonData = null;

    Map<String, String> queryParams = {
      'subject': id,
    };
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String url = "https://app-e-exam.herokuapp.com/getSpacificExam";
    var uri = Uri(
        scheme: 'https',
        host: 'app-e-exam.herokuapp.com',
        path: 'getSpacificExam/$id',
        queryParameters: queryParams);
    var response = await http.get(uri, headers: header);
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      final data = jsonData["data"];

      for (int i = 0; i < data.length; i++) {
        idExam.add(jsonData["data"][i]["_id"]);
        nameOfExam.add(jsonData["data"][i]["examName"]);
        timer.add(jsonData["data"][i]["timer"]);
        Score.add(jsonData["data"][i]["finalScore"]);
      }
      setState(() {
        _isLoading = false;
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>cardExamsProf(idExam: idExam, nameOfExam: nameOfExam, timer: timer, Score: Score, token: widget.token,)), );
      });
      print(jsonData);
    } else {
      print(jsonData);
    }
  }
}