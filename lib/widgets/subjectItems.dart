import 'package:flutter/material.dart';
class subjectItems extends StatelessWidget {

  //final String id;

  //final String subjectName;
  // subjectItems({ required this.id, required this.subjectName});
  final  Sname;

  const subjectItems({ this.Sname}) ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color:  Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ Theme.of(context).primaryColor, Theme.of(context).accentColor]),
        ),
        child: Text(
         Sname,
          style:TextStyle(fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white) ,
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {},
    );;
  }
}
