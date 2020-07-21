import 'dart:async';
import 'package:flutter/material.dart';
import 'categories.dart';
import 'user.dart';
import 'signup.dart';
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'cognitoSignIn.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flip_card/flip_card.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

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
          String mail = _user.email;
          globals.currentUser = mail.substring(0, mail.indexOf('@'));
          return Material(
            type: MaterialType.transparency,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  backgroundColor: Colors.purple[900],
                  title: Center(
                    child: Text(
                      'UltraTrivia',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  actions: <Widget>[
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
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        _userService.signOut();
                        //Navigator.pop(context);
                        navigateToLogin(context);
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
                    const SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        child: Text(
                          'Welcome ${globals.currentUser}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange,
                            fontFamily: 'Satisfy',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        child: FutureBuilder<GetPoints>(
                            future: getPoints(globals.email),
                            builder: (context, user) {
                              if (user.hasData) {
                                return Center(
                                    child: Text(
                                  'UltraTrivia Player Score\n ' +
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: new Container(
                        width: 350,
                        height: 300,
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "\nGAMEPLAY INSTRUCTIONS\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '1. Choose a category of questions\n'
                                  '2. Answer questions within time limit\n'
                                  '3. Try until you get max points\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Enjoy!\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Center(
                                child: new RaisedButton(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'View LeaderBoard',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    _launchURL();
                                  },
                                  color: Colors.purple[900],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.purple)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 95, vertical: 80),
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
        return Scaffold(
          appBar: AppBar(
            title: Text('Loading...'),
            backgroundColor: Colors.purple[900],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.purple]),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
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
  Navigator.pushReplacement(
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

_launchURL() async {
  const url = 'https://mernstack-1.herokuapp.com/home';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
