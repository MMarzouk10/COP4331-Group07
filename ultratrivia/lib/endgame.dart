import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ultratrivia/gameplay.dart';
import 'categories.dart';
import 'signin.dart';
import 'dart:io';
import 'user.dart';
import 'signup.dart';
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

class EndGameScreen extends StatefulWidget {
  @override
  _EndGameState createState() => _EndGameState();
}

class _EndGameState extends State<EndGameScreen> {
  Future<SetPoints> setPoints;
  Future<GetPoints> myPoints;
  @override
  void initState() {
    setPoints = sendPoints(globals.email, globals.resPoints);
    myPoints = getPoints(globals.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.purple[900],
            title: Center(
              child: Text(
                'Game Points: ${globals.resPoints}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Future.delayed(
                    Duration.zero,
                    () {
                      navigateToSignUpPage(context);
                    },
                  );
                },
              ),
            ]),
        body: new Container(
          //backgroundColor: Colors.deepPurple,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.purple])),

          child: Column(
            children: <Widget>[
              const SizedBox(height: 180),
              FutureBuilder<GetPoints>(
                  future: myPoints,
                  builder: (context, user) {
                    if (user.hasData) {
                      return Center(
                          child: Text(
                        user.data.points.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Satisfy',
                        ),
                        textAlign: TextAlign.center,
                      ));
                    } else if (user.hasError) {
                      return Text(
                        "${user.error}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                    fontFamily: 'Satisfy',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        //child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 150),
          child: FloatingActionButton.extended(
            onPressed: () {
              navigateToCategoriesPage(context);
            },
            label: Text(
              'Start a New Game',
              style: TextStyle(fontSize: 20),
            ),
            icon: Icon(Icons.videogame_asset),
            backgroundColor: Colors.purple[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.purple)),
          ),
        ),
      ),
    );
  }
}

Future navigateToSignUpPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignUpPage()));
}

Future navigateToCategoriesPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Categories()));
}
