import 'package:flutter/material.dart';
import 'package:quizzlette/colors.dart';
import 'home_screen.dart';

class IntroScreen extends StatelessWidget {
  var myData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 150.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270.0,
                height: 270.0,
                child: Image(
                  image: AssetImage('asset/welcomeImage.png'),
                ),
              ),
            ),
            Text(
              'Welcome in quizlette!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0D0B1E),
                  fontSize: 36.0,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 80.0),
            RaisedButton(
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getData()));
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: 130.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    'START',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
