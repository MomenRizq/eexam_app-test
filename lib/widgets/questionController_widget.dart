import 'package:e_exam_app/pages/professor/home_Screen_Professor.dart';
import 'package:e_exam_app/widgets/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'task.dart';

class Questions_Controller extends StatefulWidget {
  final idExam;
  final token;

  const Questions_Controller(this.idExam, this.token);

  @override
  State<Questions_Controller> createState() => _Questions_ControllerState();
}

class _Questions_ControllerState extends State<Questions_Controller> {
  var formKey = GlobalKey<FormState>();

  TextEditingController QController = TextEditingController();

  TextEditingController aController = TextEditingController();

  TextEditingController bController = TextEditingController();

  TextEditingController cController = TextEditingController();

  TextEditingController dController = TextEditingController();

  TextEditingController correctAnswerController = TextEditingController();
  List<Task> listTasks = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Questions'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: QController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Question';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Add Question',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.blue,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: aController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter answer';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Answer 1',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.blue,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: bController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter answer';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Answer 2',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.blue,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: cController,
                  decoration: InputDecoration(
                      hintText: 'Answer 3',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.blue,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: dController,
                  decoration: InputDecoration(
                      hintText: 'Answer 4',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.blue,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: correctAnswerController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Correct answer';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Correct answer',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.blue,
                      )),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        AddMCQ(
                            widget.idExam,
                            widget.token,
                            QController.text,
                            aController.text,
                            bController.text,
                            cController.text,
                            dController.text,
                            correctAnswerController.text);
                        onAddPressed();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Add MCQ',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        AddTrueFalse(
                            widget.idExam,
                            widget.token,
                            QController.text,
                            aController.text,
                            bController.text,
                            correctAnswerController.text);
                        onAddPressed();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Add T & F',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onDonePressed,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return taskItem(listTasks[index]);
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: listTasks.length),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddPressed() {
    if (formKey.currentState!.validate()) {
      listTasks.add(Task(
          question: QController.text,
          A1: aController.text,
          A2: bController.text,
          A3: cController.text,
          A4: dController.text,
          AC: correctAnswerController.text));
    }
    setState(() {
      QController.clear();
      aController.clear();
      bController.clear();
      cController.clear();
      dController.clear();
      correctAnswerController.clear();
    });
  }

  void onDonePressed() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (context) => homeScreenProfessor(token: widget.token,)));
  }

  Widget taskItem(Task model) {
    return Container(
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
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            ("Q- ${model.question}"),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
          SizedBox(height: 8,),
          Text(
            ("a- ${model.A1}"),
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 5,),
          Text(
            ("b- ${model.A2}"),
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 5,),
          Text(
            ("c- ${model.A3}"),
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 5,),
          Text(
            ("d- ${model.A4}"),
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 5,),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          Text(
            ("Correct Answer : ${model.AC}"),
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.green , fontStyle : FontStyle.italic ),
          ),
        ],
      ),
    );
  }

  Future<void> AddMCQ(
      String idExam,
      String token,
      String Question,
      String answer1,
      String answer2,
      String answer3,
      String answer4,
      String correctAnswer) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/addMcqQuestion';
    Map data = {
      "exam": idExam,
      "question": Question,
      "answer1": answer1,
      "answer2": answer2,
      "answer3": answer3,
      "answer4": answer4,
      "correctAnswer": correctAnswer,
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
    if (response.statusCode == 200) {
      final data = jsonData["data"];
      setState(() {
        _isLoading = false;
      });
      print(jsonData);
    } else {
      print(jsonData);
    }
  }
  Future<void> AddTrueFalse(
      String idExam,
      String token,
      String Question,
      String answer1,
      String answer2,
      String correctAnswer) async {
    var jsonData = null;
    var uri = 'https://app-e-exam.herokuapp.com/trueFalsQuestion';
    Map data = {
      "exam": idExam,
      "question": Question,
      "answer1": answer1,
      "answer2": answer2,
      "correctAnswer": correctAnswer,
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
    if (response.statusCode == 200) {
      final data = jsonData["data"];
      setState(() {
        _isLoading = false;
      });
      print(jsonData);
    } else {
      print(jsonData);
    }
  }
}
