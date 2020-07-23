import 'package:flutter/material.dart';
import 'package:quizzlette/Screens/intro_screen.dart';
import 'package:quizzlette/colors.dart';

class ResultScreen extends StatelessWidget {
  int finalScore;
  ResultScreen({@required this.finalScore});

  String image;
  String text;
  Color textColor;

  int getPercentageScore(int finalScore) {
    int percentageScore;
    percentageScore = (finalScore * 0.2 * 100).toInt();
    return percentageScore;
  }

  String setImage(int finalScore) {
    if (finalScore == 0) {
      image = 'bad';
      return image;
    } else {
      image = 'winners';
      return image;
    }
  }

  String setText(int finalScore) {
    if (finalScore == 0) {
      text = 'Try again!';
      return text;
    } else {
      text = 'Congratulations!';
      return text;
    }
  }

  Color colorText(int finalScore) {
    if (finalScore == 0) {
      textColor = kIncorrectAnswer;
      return textColor;
    } else {
      textColor = kCorrectAnswer;
      return textColor;
    }
  }

  void _sendScore(BuildContext context) {
    int finalScoreToSend = 0;
    Navigator.pop(context, finalScoreToSend);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: gradient),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 40.0, bottom: 40.0, left: 30.0, right: 30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(width: 32.0, height: 0.0),
                  Text(
                    'Quiz result',
                    style: TextStyle(
                        color: Color(0xFF0D0B1E),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Color(0xFF0D0B1E),
                        size: 26.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IntroScreen()));
                      })
                ],
              ),
              SizedBox(height: 40.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                height: 440.0,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                          width: 220.0,
                          height: 220.0,
                          child: Image(
                              image: AssetImage(
                                  'asset/${setImage(finalScore)}.png'))),
                    ),
                    Text(
                      setText(finalScore),
                      style: TextStyle(
                          color: Color(0xFF0D0B1E),
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 35.0),
                    Text(
                      '${getPercentageScore(finalScore).toString()}% Score',
                      style: TextStyle(
                          color: colorText(finalScore),
                          fontSize: 40.0,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${finalScore.toString()} from 5 answers is correct.',
                      style: TextStyle(
                          color: Color(0xFF0D0B1E),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              ButtonTheme(
                minWidth: 180.0,
                height: 50.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                buttonColor: Color(0xFF0D0B1E),
                child: RaisedButton(
                  onPressed: () {
                    _sendScore(context);
                  },
                  child: Text(
                    'RETAKE QUIZ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
