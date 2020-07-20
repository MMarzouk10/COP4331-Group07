import 'package:flutter/material.dart';
import 'package:ultratrivia/categories.dart';
import 'package:ultratrivia/signup.dart';
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
      //home: Categories(),
      home: SignUpPage(),
      //home: LoginScreen(),
      //home: EndGameScreen(),
    );
  }
}
