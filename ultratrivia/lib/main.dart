import 'package:flutter/material.dart';
import 'package:ultratrivia/categories.dart';
import 'package:ultratrivia/signup.dart';
import 'package:ultratrivia/splash.dart';
//import 'package:link/link.dart';
//import 'dart:io';
//import 'package:http/http.dart';
import 'signup.dart';
import 'gameplay.dart';
import 'categories.dart';
import 'cognitoSignIn.dart';
import 'endgame.dart';

void main() => runApp(UltraTrivia());

class UltraTrivia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ultra Trivia',
      home: SignUpPage(),
      routes: <String, WidgetBuilder>{
        '/signupscreen': (BuildContext context) => new SignUpPage(),
        '/landingscreen': (BuildContext context) => new SplashScreen(),
        '/loginscreen': (BuildContext context) => new LoginScreen(),
        '/categoriesscreen': (BuildContext context) => new Categories(),
        '/gameplaycreen': (BuildContext context) => new GamePlayPage(),
        '/endgamescreen': (BuildContext context) => new EndGameScreen(),
      },
    );
  }
}
