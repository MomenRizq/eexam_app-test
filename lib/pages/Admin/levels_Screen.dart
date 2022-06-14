import 'dart:convert';
import 'dart:io';
import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/Admin/Comp_levels.dart';
import 'package:e_exam_app/pages/student/quize_screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class levelsScreen extends StatefulWidget {
   final List<String> idOfLevels;
  final List<String>nameOfLevels;
  final String token;
   levelsScreen({ required this.idOfLevels,required  this.nameOfLevels,required  this.token});



  @override
  State<levelsScreen> createState() => _levelsScreenState();
}

class _levelsScreenState extends State<levelsScreen> {
  bool _isLoading = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController levelsController = TextEditingController();

  List<Level> listTasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
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
              widget.nameOfLevels.clear();
            });
          },
        ) ,
        backgroundColor: Colors.purple,
        title: Text(
          'Levels',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold , color:Colors.white ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  scaffoldKey.currentState?.showBottomSheet((context) =>Container(
                    height: 200,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black12,
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            controller: levelsController,
                            decoration: InputDecoration(
                                hintText: 'Add Level',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                fillColor: Colors.black12,
                                suffixIcon: Icon(
                                  Icons.drive_file_rename_outline,
                                  color: Colors.black12,
                                )),

                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: (){
                            print(listTasks.length);
                            setState(() {
                              addLevels_api(levelsController.text, widget.token);
                            },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Add',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.add),

                  // child: Center(child: Text('Add Level')),
                ),
              ),
             for(int i = 0 ; i< widget.nameOfLevels.length ; i++)
              Container(
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
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Container(
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(widget.nameOfLevels[i],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white)),
                        ),
                      ]),
                    ),
                    Spacer(),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.delete) , color: Colors.red,
                        onPressed: () {
                          deleteLevels_api(widget.idOfLevels[i], widget.token);

                        },
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return taskItem(listTasks[index]);
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: listTasks.length),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }

  Widget taskItem(Level model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(model.levels,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
          Spacer(),
          Container(
            child: IconButton(
              icon: Icon(Icons.delete),color: Colors.red,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
  deleteLevels_api(String id, String token) async {
    var message ;
    var jsonData1 = null;
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String url = "https://app-e-exam.herokuapp.com/removeLevels";
    var uri = Uri(
        scheme: 'https',
        host: 'app-e-exam.herokuapp.com',
        path: 'removeLevels/$id',
    );
    var response = await http.delete(uri, headers: header);

    jsonData1 = json.decode(response.body);
    final data = jsonData1;
    int n = data.length;
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });

      print(jsonData1);
      message = jsonData1["message"];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog(
              "Error",
              message,
              context);
        },
      );
    } else {
      print(jsonData1);
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

  addLevels_api(String Name, String token) async {
    var jsonData = null;
    var message ;
    var uri = 'https://app-e-exam.herokuapp.com/addLevels';
    Map data = {
      "levelName":Name,
    };
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: body
    );
    jsonData = json.decode(response.body);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      setState(() {
        listTasks.add(Level(levels: levelsController.text));
        levelsController.clear();
        _isLoading = false;
      });
      print(jsonData);
     message = jsonData["message"];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog(
              "Success",
              message,
              context,);
        },
      );
    } else {
      print(jsonData);
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