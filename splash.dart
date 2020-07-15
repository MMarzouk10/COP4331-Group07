import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:ultra_trivia/home.dart';
import 'dart:io';
import 'user.dart';
import 'signup.dart';
import 'globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class Constants {
  static const String ChangePassword = 'Change Password';
  static const String ChangeEmail = 'Change Email';
  static const String ChangeLogin = 'Change Login';
  static const String FAQ = 'FAQ';
  static const List<String> choices = <String>[
    ChangePassword,
    ChangeEmail,
    ChangeLogin,
    FAQ
  ];
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.purple[900],
            title: Text('Hello ${globals.userName}'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  navigateToSignUp(context);
                },
              ),
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              )
            ]),
        body: new Container(
          //backgroundColor: Colors.deepPurple,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.purple])),
          child: Center(
            child: Text(
              'ScoreBoard',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontFamily: 'Satisfy',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 150),
          child: FloatingActionButton.extended(
            onPressed: () {
              /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => homepage(),
              )
              );*/
            },
            label: Text('Start Game'),
            icon: Icon(Icons.videogame_asset),
            backgroundColor: Colors.purple[900],
          ),
        ),
      ),
    );
  }
}

Future navigateToSignUp(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignUpPage()));
}

void choiceAction(String choice) {
  if (choice == Constants.ChangePassword) {
    print('ChangePassword');
  } else if (choice == Constants.ChangeEmail) {
    print('ChangeEmail');
  } else if (choice == Constants.ChangeLogin) {
    print('ChangeLogin');
  } else if (choice == Constants.FAQ) {
    print('FAQ');
  }
}
