import 'dart:convert';
import 'dart:io';

import 'package:e_exam_app/common/theme_helper.dart';
import 'package:e_exam_app/pages/Admin/Comp_Subject.dart';
import 'package:e_exam_app/pages/Admin/Comp_levels.dart';
import 'package:e_exam_app/pages/Admin/Comp_prof.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfScreenAdmin extends StatefulWidget {
  static String ROUTE_NAME = 'subjects';
  final List ProfFirstName;
  final List ProfLastName;
  final List ProfId;
  final List ProfEmail;
  final token;

  const ProfScreenAdmin({ required this.ProfFirstName,required this.ProfLastName,required this.ProfId,required this.ProfEmail, this.token}) ;


  @override
  State<ProfScreenAdmin> createState() => _ProfScreenAdminState();
}

class _ProfScreenAdminState extends State<ProfScreenAdmin> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ProfFirstNameController = TextEditingController();
  TextEditingController ProfLastNameController = TextEditingController();
  TextEditingController ProfEmailController = TextEditingController();
  TextEditingController ProfPassController = TextEditingController();

  List<Prof> listProfs = [];




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
           widget.ProfEmail.clear();
           widget.ProfId.clear();
           widget.ProfFirstName.clear();
           widget.ProfLastName.clear();
            });
          },
        ) ,
        title: Text(
          'Professors',
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
                    height: 400,
                    child:ListView(
                      children: [
                        Container(
                          color: Colors.black12,
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            controller: ProfFirstNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter First Name',
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
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            controller:ProfLastNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Last Name',
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
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            controller:ProfEmailController,
                            decoration: InputDecoration(
                                hintText: 'Enter Email',
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
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            controller:ProfPassController,
                            decoration: InputDecoration(
                                hintText: 'Enter Pssword',
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
                            setState(
                                  () {
                                addProf_api(widget.token,ProfFirstNameController.text,ProfLastNameController.text,ProfEmailController.text,ProfPassController.text );
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
              for(int i =0 ;i<widget.ProfId.length ;i++)
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
                                  "${widget.ProfFirstName[i]}  ${widget.ProfLastName[i]} ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  widget.ProfEmail[i],
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
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Id : ${widget.ProfId[i]}",
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
                              icon: Icon(Icons.delete ), color: Colors.red,
                              onPressed: () {
                                deleteProf_api(widget.ProfId[i], widget.token);
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
                        return profItem(listProfs[index]);
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: listProfs.length),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profItem(Prof model) {
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
                      "${model.firstNameProf}  ${model.lastNameProf} ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                    model.emailProf,
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
                  icon: Icon(Icons.delete ), color: Colors.red,
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

  addProf_api(String token, String FirstName, String LastName,String Email, String Pass) async {
    var jsonData = null;
    var message ;
    var uri = 'https://app-e-exam.herokuapp.com/addProfessor';
    Map data = {
      "fristName":FirstName,
      "lastName": LastName,
      "email":Email,
      "password":Pass,
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

    if (response.statusCode == 200 || response.statusCode == 4) {

      setState(() {
        listProfs.add(Prof(
            firstNameProf: ProfFirstNameController.text,
            lastNameProf: ProfLastNameController.text,
            emailProf: ProfEmailController.text,
            passwordProf: ProfPassController.text
        ));
        ProfFirstNameController.clear();
        ProfLastNameController.clear();
        ProfEmailController.clear();
        ProfPassController.clear();
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
  deleteProf_api(String id, String token) async {
    var message ;
    var jsonData1 = null;
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String url = "https://app-e-exam.herokuapp.com/deleteUser";
    var uri = Uri(
      scheme: 'https',
      host: 'app-e-exam.herokuapp.com',
      path: 'deleteUser/$id',
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
              "Success",
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
