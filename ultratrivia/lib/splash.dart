import 'dart:async';
import 'package:flutter/material.dart';
import 'categories.dart';
import 'signin.dart';
import 'dart:io';
//import 'user.dart';
import 'signup.dart';
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'cognitoSignIn.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
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

class _SplashScreenState extends State<SplashScreen> {
  final _userService = UserService(userPool);
  User _user = User();
  bool _isAuthenticated = false;

  Future<UserService> _getValues(BuildContext context) async {
    try {
      await _userService.init();
      _isAuthenticated = await _userService.checkAuthenticated();
      if (_isAuthenticated) {
        // get user attributes from cognito
        _user = await _userService.getCurrentUser();
      }
      return _userService;
    } on CognitoClientException catch (e) {
      if (e.code == 'NotAuthorizedException') {
        await _userService.signOut();
        Navigator.pop(context);
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getValues(context),
      builder: (context, AsyncSnapshot<UserService> snapshot) {
        if (snapshot.hasData) {
          if (!_isAuthenticated) {
            return LoginScreen();
          }
          globals.email = _user.email;
          return Material(
            type: MaterialType.transparency,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  backgroundColor: Colors.purple[900],
                  title: Text(
                    '${globals.email}',
                    //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        _userService.signOut();
                        //Navigator.pop(context);
                        navigateToLogin(context);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 95, vertical: 150),
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
        return Scaffold(appBar: AppBar(title: Text('Loading...')));
      },
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

Future navigateToLogin(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
