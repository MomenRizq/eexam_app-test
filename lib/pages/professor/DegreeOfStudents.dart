import 'dart:convert';
import 'dart:io';
import 'package:e_exam_app/pages/professor/quizProf_screen.dart';
import 'package:e_exam_app/pages/student/quize_screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class DrgreeOfStudents extends StatefulWidget {
  final List<String> name ;
  final List<int> Score ;

  const DrgreeOfStudents({ required this.name,required  this.Score}) ;


  @override
  State<DrgreeOfStudents> createState() => _DrgreeOfStudentsState();
}

class _DrgreeOfStudentsState extends State<DrgreeOfStudents> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Exams",
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
                      Theme
                          .of(context)
                          .primaryColor,
                      Theme
                          .of(context)
                          .accentColor,
                    ])),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
              setState(() {
               widget.Score.clear();
               widget.name.clear();
              });
            },
          ) ,
        ),
        body: GridView(
            padding: EdgeInsets.all(25),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3 / 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              for (int i = 0; i < widget.Score.length; i++)
                InkWell(
                  child: Container(
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
                          ("Name : ${widget.name[i]}"),
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "Score : ${widget.Score[i]} ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: (){ },
                ),
            ]));
  }

}