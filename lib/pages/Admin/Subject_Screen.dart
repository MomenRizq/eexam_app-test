import 'dart:convert';
import 'dart:io';

import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/Admin/Comp_Subject.dart';
import 'package:e_exam_app/pages/Admin/Comp_levels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class subjectsScreenAdmin extends StatefulWidget {
  static String ROUTE_NAME = 'subjects';
  final List SubjectsName;
  final List SubjectsId;
  final List SubjectsLevel;
  final List SubjectsDeprt;
  final List SubjectsProf;
  final token;

  const subjectsScreenAdmin(this.SubjectsName, this.SubjectsId, this.token, this.SubjectsLevel, this.SubjectsDeprt, this.SubjectsProf);
  @override
  State<subjectsScreenAdmin> createState() => _subjectsScreenAdminState();
}

class _subjectsScreenAdminState extends State<subjectsScreenAdmin> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController SubjectNameController = TextEditingController();
  TextEditingController DepNameController = TextEditingController();
  TextEditingController LevelNameController = TextEditingController();
  TextEditingController ProfNameController = TextEditingController();
  List<Comp> listComps = [];




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
              widget.SubjectsName.clear();
              widget.SubjectsProf.clear();
              widget.SubjectsLevel.clear();
              widget.SubjectsDeprt.clear();
              widget.SubjectsId.clear();
            });
          },
        ) ,
        title: Text(
          'Subjects',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ,color: Colors.white),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  scaffoldKey.currentState
                      ?.showBottomSheet((context) => Container(
                    height: 500,
                    child:ListView(
                      children: [
                        Container(
                          color: Colors.black12,
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: SubjectNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Subject Name',
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
                        SizedBox(height: 2,),
                        Container(
                          color: Colors.black12,
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller:DepNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Department Name',
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
                        SizedBox(height: 2,),
                        Container(
                          color: Colors.black12,
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller:LevelNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Level Name',
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
                        SizedBox(height: 2,),
                        Container(
                          color: Colors.black12,
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: ProfNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Email of Professor',
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
                        Spacer(),

                        ElevatedButton(
                          onPressed: () {

                            Navigator.pop(context);
                            print(listComps.length);
                            setState(
                                  () {
                                    addSubject_api(SubjectNameController.text, widget.token, DepNameController.text, LevelNameController.text, ProfNameController.text);
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
                              backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30),
                                ),
                              )),
                        ),
                        Spacer(),
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
              for(int i =0 ;i<widget.SubjectsName.length ;i++)
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.SubjectsName[i],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Dep: ${widget.SubjectsDeprt[i]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Level: ${widget.SubjectsLevel[i]}",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white,)),
                            ),
                          ],
                        ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                widget.SubjectsProf[i],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                      ]),
                    ),
                    Spacer(),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete) , color: Colors.red,
                            onPressed: () {
                              deleteSubject_api(widget.SubjectsId[i],widget.token);
                            },
                          ),
                        ],
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
                        return compItem(listComps[index]);
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: listComps.length),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget compItem(Comp model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model.namofsub,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Dep: ${model.namofdep}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Level: ${model.namoflevel}",
                            style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold , color: Colors.white,)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      model.namofprof,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ]),
          ),
          Spacer(),
          Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.delete) , color: Colors.red,
                  onPressed: () {
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  addSubject_api(String Name, String token, String Dep,String level , String Prof) async {
    var jsonData = null;
    var message ;
    var uri = 'https://app-e-exam.herokuapp.com/addSubject';
    Map data = {
      "subjectName":Name,
      "department": Dep,
      "level":level,
      "prof":Prof,
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
        listComps.add(Comp(
            namofdep:DepNameController.text,
            namofsub: SubjectNameController.text,
            namoflevel: LevelNameController.text,
            namofprof: ProfNameController.text
        ));
        DepNameController.clear();
        SubjectNameController.clear();
        LevelNameController.clear();
        ProfNameController.clear();
      });
      print(jsonData);
      message = jsonData["message"];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ThemeHelper().alartDialog(
              "Success",
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
  deleteSubject_api(String id, String token) async {
    var message ;
    var jsonData1 = null;
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String url = "https://app-e-exam.herokuapp.com/removeSubject";
    var uri = Uri(
      scheme: 'https',
      host: 'app-e-exam.herokuapp.com',
      path: 'removeSubject/$id',
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

}
