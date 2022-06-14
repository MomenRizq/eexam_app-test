import 'dart:convert';
import 'dart:io';

import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/Admin/Comp_Dep.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class departmentsScreen extends StatefulWidget {
  static String ROUTE_NAME='departments';
  final List<String> idOfDepartment;
  final List<String>nameOfDepartment;
  final String token;

  const departmentsScreen({ required this.idOfDepartment,required this.nameOfDepartment,required this.token});


  @override
  State<departmentsScreen> createState() => _departmentsScreenState();
}

class _departmentsScreenState extends State<departmentsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController depController = TextEditingController();
  List<Depart> listDeparts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar:AppBar(
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
              widget.nameOfDepartment.clear();
            });
          },
        ) ,
        title:Text('Departments',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color:Colors.white
        ),),

      ) ,
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
                            controller: depController,
                            decoration: InputDecoration(
                                hintText: 'Add Department',
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
                            print(listDeparts.length);
                            setState(() {
                              addDepartment_api(depController.text, widget.token);
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
              for(int i = 0 ; i<widget.nameOfDepartment.length;i++)
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
                          child: Text(widget.nameOfDepartment[i],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
                        ),
                      ]),
                    ),
                    Spacer(),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.delete , color: Colors.red,),
                        onPressed: () {
                          deleteDepartment_api(widget.idOfDepartment[i], widget.token);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),

              Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return departItem(listDeparts[index]);
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: listDeparts.length),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
  Widget departItem(Depart model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(model.dep,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
          Spacer(),
          Container(
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  deleteDepartment_api(String id, String token) async {
    var message ;
    var jsonData1 = null;
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String url = "https://app-e-exam.herokuapp.com/deleteDepartment";
    var uri = Uri(
      scheme: 'https',
      host: 'app-e-exam.herokuapp.com',
      path: 'deleteDepartment/$id',
    );
    var response = await http.delete(uri, headers: header);

    jsonData1 = json.decode(response.body);
    final data = jsonData1;
    int n = data.length;
    if (response.statusCode == 200) {
      setState(() {
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
  addDepartment_api(String Name, String token) async {
    var jsonData = null;
    var message ;
    var uri = 'https://app-e-exam.herokuapp.com/addDepartment';
    Map data = {
      "departmentName":Name,
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
        listDeparts.add(Depart(dep: depController.text));
        depController.clear();

      });
      print(jsonData);
      message = jsonData["message"];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog(
              "Sucess",
              message,
              context);
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
