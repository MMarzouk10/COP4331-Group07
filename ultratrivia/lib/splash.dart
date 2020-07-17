import 'dart:async';
import 'package:flutter/material.dart';
import 'categories.dart';
import 'signin.dart';
import 'dart:io';
import 'user.dart';
import 'signup.dart';
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
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

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.purple[900],
            title: Text(
              'Hello ${globals.userName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: new InkWell(
                        onTap: () {
                          if (choice == 'FAQ')
                            _launchFAQ();
                          else
                            _launchProfile();
                        },
                        child: Text(choice),
                      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 95, vertical: 150),
          child: FloatingActionButton.extended(
            onPressed: () {
              navigateToCategoriesPage(context);
            },
            label: Text(
              'Start Game',
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

Future navigateToSignUpPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignUpPage()));
}

Future navigateToCategoriesPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Categories()));
}

_launchFAQ() async {
  const url = 'https://mernstack-1.herokuapp.com/FAQ';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchProfile() async {
  const url = 'http://mernstack-1.herokuapp.com/Profile';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
