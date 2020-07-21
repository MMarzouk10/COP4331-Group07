import 'dart:async';
import 'package:flutter/material.dart';
import 'user.dart';
import 'globals.dart' as globals;

class EndGameScreen extends StatefulWidget {
  @override
  _EndGameState createState() => _EndGameState();
}

class _EndGameState extends State<EndGameScreen> {
  //Future<GetPoints> myPoints;
  @override
  void initState() {
    _setPoints();
    //myPoints = getPoints(globals.email);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        getPoints(globals.email);
      });
    });
    super.initState();
  }

  Future _setPoints() async {
    sendPoints(globals.email, globals.resPoints);
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.purple])),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Center(
                child: Text(
                  globals.endGame,
                  style: TextStyle(
                    fontSize: globals.endGame == "Times Up" ? 50.0 : 30,
                    color: Colors.white,
                    fontFamily: 'Satisfy',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  child: Text(
                    'Nice Game\n ${globals.currentUser}!\n You answered ${globals.resPoints} questions correct!',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.orange,
                      //fontFamily: 'Satisfy',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'Game Summary',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Satisfy',
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Game Points Earned: ${globals.resPoints}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: 'Satisfy',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<GetPoints>(
                  future: getPoints(globals.email),
                  builder: (context, user) {
                    if (user.hasData) {
                      return Center(
                          child: Text(
                        'UltraTrivia Player Score: ' +
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
            ],
          ),
        ),

        //child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 120),
          child: FloatingActionButton.extended(
            onPressed: () {
              navigateToCategoriesPage(context);
            },
            label: Text(
              'Start a New Game',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            icon: Icon(Icons.videogame_asset),
            backgroundColor: Colors.purple[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
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
