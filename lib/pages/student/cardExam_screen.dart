import 'dart:convert';
import 'dart:io';
import 'package:e_exam_app/pages/student/quize_screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class cardExams extends StatefulWidget {
  final List<String> idExam;

  final List<String> nameOfExam;
  final List<int> timer;

  final List<int> Score;
  final String token;


  cardExams({required this.idExam,
    required this.nameOfExam,
    required this.timer,
    required this.Score,
    required this.token});

  @override
  State<cardExams> createState() => _cardExamsState();
}

class _cardExamsState extends State<cardExams> {
  bool _isLoading = false;

  List<String> _Questions = [];
  List<String> _answer1 = [];
  List<String> _answer2 = [];
  List<String> _answer3 = [];
  List<String> _answer4 = [];
  List<String> _correctanswer = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Exams",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
              setState(() {
                widget.Score.clear();
                widget.idExam.clear();
                widget.nameOfExam.clear();
                widget.timer.clear();
              });
            },
          ) ,
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
        body: GridView(
            padding: EdgeInsets.all(25),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3 / 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              for (int i = 0; i < widget.idExam.length; i++)
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
                          widget.nameOfExam[i],
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
                          "Time : ${widget.timer[i]}  Score:${widget.Score[i]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Quize_api(widget.idExam[i], widget.token);
                          setState(() {

                          });
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ]));
  }

  Quize_api(String id, String token) async {
    var jsonData = null;

    Map<String, String> queryParams = {
      'subject': id,
    };
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String url = "https://app-e-exam.herokuapp.com/getSpacificQuestion";
    var uri = Uri(
        scheme: 'https',
        host: 'app-e-exam.herokuapp.com',
        path: 'getSpacificQuestion/$id',
        queryParameters: queryParams);
    var response = await http.get(uri, headers: header);
    jsonData = json.decode(response.body);
    final data = jsonData;
    int n = data.length;
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        for (int i = 0; i < data.length; i++) {
          _Questions.add(jsonData[i]["question"]);
          _answer1.add(jsonData[i]["answer1"]);
          _answer2.add(jsonData[i]["answer2"]);
          _answer3.add(jsonData[i]["answer3"]);
          _answer4.add(jsonData[i]["answer4"]);
          _correctanswer.add(jsonData[i]["correctAnswer"]);
        }


        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => quizeScreen(
              Questions: _Questions,
              answer1: _answer1,
              answer2: _answer2,
              answer3: _answer3,
              answer4: _answer4,
              correctanswer: _correctanswer,
              idExam: id,
              token: widget.token,)
            )
        );
      });
      print(_Questions);
      print(jsonData);
    } else {
      print(jsonData);
    }
  }
}