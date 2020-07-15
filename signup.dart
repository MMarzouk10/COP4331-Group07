import 'package:flutter/material.dart';
//import 'package:link/link.dart';
//import 'dart:io';
//import 'package:http/http.dart';
import 'package:ultratrivia/signin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUp createState() {
    return new SignUp();
  }
}

class SignUp extends State<SignUpPage> {
  String serverResponse = 'Server response';

  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Ultra Trivia',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 80.0,
                  child: RaisedButton(
                    onPressed: () async {
                      _launchURL();
                      await new Future.delayed(const Duration(seconds: 5));
                      navigateToSignIn(context);
                    },
                    child: Text('Sign Up'),
                    color: Colors.deepPurpleAccent,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 80.0,
                  child: RaisedButton(
                    onPressed: () {
                      //checkLoginStatus();
                      navigateToSignIn(context);
                    },
                    child: Text('Sign In'),
                    color: Colors.deepPurpleAccent,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future navigateToSignIn(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

  _launchURL() async {
    const url = 'https://mernstack-1.herokuapp.com/signup';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
