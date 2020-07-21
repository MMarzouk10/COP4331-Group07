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
                'UltraTrivia',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Future.delayed(
                    Duration.zero,
                    () {
                      navigateToSplashScreen(context);
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
              const SizedBox(height: 60),
              Center(
                child: SizedBox(
                  child: Text(
                    'Nice Game\n ${globals.currentUser}!\n See your game summary below:',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.orange,
                      //fontFamily: 'Satisfy',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Game Points: ${globals.resPoints}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: 'Satisfy',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<GetPoints>(
                  future: myPoints,
                  builder: (context, user) {
                    if (user.hasData) {
                      return Center(
                          child: Text(
                        'Total UltraTrivia Points: ' +
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
              const SizedBox(height: 80),
              Center(
                child: Text(
                  'TIMES UP!',
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
          padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 150),
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

Future navigateToSplashScreen(context) async {
  Navigator.popAndPushNamed(context, '/landingscreen');
}

Future navigateToCategoriesPage(context) async {
  Navigator.popAndPushNamed(context, '/categoriesscreen');
}
