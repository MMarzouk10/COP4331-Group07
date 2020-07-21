import 'package:flutter/material.dart';
//import 'package:link/link.dart';
//import 'dart:io';
//import 'package:http/http.dart';
//import 'signin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cognitoSignIn.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'UltraTrivia',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          backgroundColor: Colors.purple[900],
        ),
        body: new Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.purple])),
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
                      navigateToLogin(context);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.purple[900],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple)),
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
                      navigateToLogin(context);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.purple[900],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple)),
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

  Future navigateToLogin(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
