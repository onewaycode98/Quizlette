import 'package:flutter/material.dart';
import 'package:quizzlette/colors.dart';
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';
import 'result_screen.dart';

class getData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      body: FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString("asset/question.json"),
        builder: (context, snapshot) {
          var mydata = json.decode(snapshot.data.toString());
          if (mydata == null) {
            return Center(
              child: Text('Loading'),
            );
          } else {
            return QuizPage(
              mydata: mydata,
            );
          }
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  var mydata;
  QuizPage({Key key, @required this.mydata});

  @override
  _QuizPageState createState() => _QuizPageState(mydata);
}

class _QuizPageState extends State<QuizPage> {
  var mydata;
  _QuizPageState(this.mydata);
  int finalScore = 0;
  int numberQuestion = 1;
  Color colorToShow = kAnswearButtonColor;
  IconData iconTOShow;
  double progress = 0;
  bool _ignoringAfterUiChange = false;

  Map<String, Color> buttonColor = {
    "a": kAnswearButtonColor,
    "b": kAnswearButtonColor,
    "c": kAnswearButtonColor,
    "d": kAnswearButtonColor,
  };

  Map<String, IconData> iconState = {
    "a": null,
    "b": null,
    "c": null,
    "d": null,
  };

  void _awaitScoreValue(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(finalScore: finalScore),
        ));

    setState(() {
      finalScore = result;
    });
  }

  void nextQuestion() {
    setState(() {
      if (numberQuestion == mydata[0].length) {
        _awaitScoreValue(context);
        numberQuestion = 1;
        progress = 0;

        // print(finalScore);
        _ignoringAfterUiChange = false;
      } else {
        numberQuestion++;
        progress = progress + 0.25;
        _ignoringAfterUiChange = false;
      }
      buttonColor["a"] = kAnswearButtonColor;
      buttonColor["b"] = kAnswearButtonColor;
      buttonColor["c"] = kAnswearButtonColor;
      buttonColor["d"] = kAnswearButtonColor;
      iconState["a"] = null;
      iconState["b"] = null;
      iconState["c"] = null;
      iconState["d"] = null;
    });
  }

  void checkAnswer(String k) {
    if (mydata[2][numberQuestion.toString()] ==
        mydata[1][numberQuestion.toString()][k]) {
      colorToShow = kCorrectAnswer;
      iconTOShow = Icons.check;
      finalScore++;
    } else {
      colorToShow = kIncorrectAnswer;
      iconTOShow = Icons.clear;
    }
    setState(() {
      buttonColor[k] = colorToShow;
      iconState[k] = iconTOShow;
      _ignoringAfterUiChange = true;
    });
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: IgnorePointer(
        ignoring: _ignoringAfterUiChange,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: buttonColor[k])),
          minWidth: double.infinity,
          height: 50.0,
          onPressed: () {
            checkAnswer(k);
          },
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: buttonColor[k],
                    ),
                    child: Icon(
                      iconState[k],
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    mydata[1][numberQuestion.toString()][k],
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Quizlette',
                    style: TextStyle(
                        color: Color(0xFF272343),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height: 50.0),
                RichText(
                  text: TextSpan(
                      text: 'Question ',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2d334a),
                          fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                            text: '$numberQuestion',
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Color(0xFF2d334a),
                                fontWeight: FontWeight.w800)),
                        TextSpan(
                            text: '/${mydata[0].length}',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF2d334a),
                                fontWeight: FontWeight.w600))
                      ]),
                ),
                SizedBox(height: 15.0),
                LinearPercentIndicator(
                  progressColor: kButtonColor,
                  backgroundColor: Colors.white,
                  percent: progress,
                  lineHeight: 6.0,
                  padding: EdgeInsets.all(0),
                ),
                SizedBox(height: 50.0),
                Stack(
                  children: [
                    Container(
                      height: 532.0,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFD1F0ED)),
                    ),
                    Container(
                      height: 517.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFE0F5F3)),
                    ),
                    Container(
                      height: 500.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 15.0, right: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Select an answer',
                              style: TextStyle(
                                  color: Color(0xFFA3A3A3),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              mydata[0][numberQuestion.toString()],
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2d334a),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            choiceButton("a"),
                            choiceButton("b"),
                            choiceButton("c"),
                            choiceButton("d"),
                            SizedBox(height: 30.0),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ButtonTheme(
                                buttonColor: kButtonColor,
                                minWidth: 140.0,
                                height: 50.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      nextQuestion();
                                    });
                                  },
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Color(0xFF272343),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
