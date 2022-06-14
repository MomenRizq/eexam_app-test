import 'dart:convert';
import 'dart:io';
import 'package:e_exam_app/pages/student/quize_screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class GradeScreen extends StatefulWidget {
  List <String> examName ;
  List <String> SubjectName;
   List <int> yourScore;

  GradeScreen({required this.examName,required this.SubjectName,required this.yourScore});
  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  var i = 0;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(i == widget.examName.length)
      {
        widget.examName = [];
        widget.SubjectName=[];
        widget.yourScore=[];
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Grade",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
              setState(() {
               widget.yourScore.clear();
              widget.SubjectName.clear();
              widget.examName.clear();
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
                      Theme
                          .of(context)
                          .primaryColor,
                      Theme
                          .of(context)
                          .accentColor,
                    ])),
          ),
        ),
        body:ListView(
            children: [
              for ( i = 0; i < widget.SubjectName.length; i++)
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme
                                .of(context)
                                .primaryColor,
                            Theme
                                .of(context)
                                .accentColor
                          ]),
                    ),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          widget.SubjectName[i],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "Exam : ${widget.examName[i]} ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      trailing:Text(
                        "your Score:${widget.yourScore[i]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
            ])



    );
  }


}