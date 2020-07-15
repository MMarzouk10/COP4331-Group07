import 'package:flutter/material.dart';
import 'package:ultratrivia/signup.dart';
//import 'package:link/link.dart';
//import 'dart:io';
//import 'package:http/http.dart';
import 'signup.dart';
import 'gameplay.dart';

void main() => runApp(UltraTrivia());

class UltraTrivia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ultra Trivia',
      //home: GamePlayPage(),
      home: SignUpPage(),
    );
  }
}
