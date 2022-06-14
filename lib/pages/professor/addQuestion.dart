import '../../widgets/questionController_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class addQuestion extends StatefulWidget {
  final List SubjectsName;
  final List SubjectsId;
  final token;

  const addQuestion(
      {required this.SubjectsName,
      required this.SubjectsId,
      required this.token});

  @override
  State<addQuestion> createState() => _addQuestionState();
}

class _addQuestionState extends State<addQuestion> {
  String? dropdownValue;

  int i = 0;

  List Name = [];
  String? idSubject;
  bool _isLoading = false ;
  String? idOfExam;

  final examName = new TextEditingController();
  final Timer = new TextEditingController();
  final finalScore = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(12),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            "Add New Exam",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Spacer(),
          Container(
            color: Colors.black12,
            child: DropdownButton(
              hint: Text('Please choose a Subject'),
              // Not necessary for Option 1
              value: dropdownValue,
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue as String?;
                  for (i = 0; i < widget.SubjectsName.length; i++) {
                    if (dropdownValue == widget.SubjectsName[i]) {
                      idSubject = widget.SubjectsId[i];
                    }
                  }
                  print(idSubject);
                });
              },
              items: widget.SubjectsName.map((Subject) {
                return DropdownMenuItem(
                  child: new Text(Subject),
                  value: Subject,
                );
              }).toList(),
            ),
          ),
          Spacer(),
          Container(
            color: Colors.black12,
            child: TextField(
              controller: examName,
              decoration: InputDecoration(
                hintText: 'Name of Exam',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Spacer(),
          Container(
            color: Colors.black12,
            child: TextField(
              controller: Timer,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintText: 'Time of exam',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Spacer(),
          Container(
            color: Colors.black12,
            child: TextField(
              controller: finalScore,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintText: 'final Score',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Spacer(),
          Container(
            child: ElevatedButton(
                onPressed: () => onAddtask(widget.token, examName.text, idSubject!,
                    int.parse(Timer.text), int.parse(finalScore.text)),
                child: Text('Add Task')),
          ),
          Spacer(),
        ]));
//
  }

  Future<void> onAddtask(String token, String examName, String Subject,
      int Timer, int Score) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/createNewExam';
    Map data = {
      "examName": examName,
      "subject": Subject,
      'timer': Timer,
      "finalScore": Score,
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(uri),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: body);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    jsonData = json.decode(response.body);
    idOfExam =  jsonData["newexam"]["_id"];

    if (response.statusCode == 200) {
      final data = jsonData["data"];
      setState(() {
        _isLoading = false;

        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Questions_Controller(idOfExam , widget.token) ));
      });
      print(jsonData);
    } else {
      print(jsonData);
    }
  }
}
