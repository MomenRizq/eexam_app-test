import 'package:flutter/material.dart';

class quizeProfScreen extends StatefulWidget {
  final List<String> Questions;

  final List<String> answer1;

  final List<String> answer2;

  final List<String> answer3;

  final List<String> answer4;

  final List<String> correctanswer;

  final idExam;
  final token;





  const quizeProfScreen({ required this.Questions,required   this.answer1,required  this.answer2,required  this.answer3,required  this.answer4,required  this.correctanswer, this.idExam, this.token}) ;
  @override
  _quizeProfScreenState createState() => _quizeProfScreenState();
}

class _quizeProfScreenState extends State<quizeProfScreen> {
  int j = 0;

  int grade = 0;

  bool disableAnswer = false;

  String allAnswers = "" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E exam',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
            setState(() {
              widget.Questions.clear();
              widget.answer1.clear();
              widget.answer2.clear();
              widget.answer3.clear();
              widget.answer4.clear();
              widget.correctanswer.clear();
            });
          },
        ) ,
      ),
      body: ListView(
        children: [
            for(int j = 0 ; j < widget.Questions.length ; j++ )
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (j < widget.Questions.length)
                    MaterialButton(
                      onPressed: () => {
                        setState(() {
                        })
                      },
                      child: Text(
                        widget.Questions[j],
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Alike",
                          fontSize: 20.0,
                        ),

                      ),
                      splashColor: Colors.indigo[700],
                      highlightColor: Colors.indigo[700],
                      minWidth: 200.0,
                      height: 200.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).accentColor
                          ]),
                    ),
                    child: InkWell(
                      child: Text(
                        widget.answer1[j],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).accentColor
                          ]),
                    ),
                    child: InkWell(
                      child: Text(
                        widget.answer2[j],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).accentColor
                          ]),
                    ),
                    child: InkWell(
                      child: Text(
                        widget.answer3[j],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).accentColor
                          ]),
                    ),
                    child: InkWell(
                      child: Text(
                        widget.answer4[j],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
        ],
      ),
    );
  }
}