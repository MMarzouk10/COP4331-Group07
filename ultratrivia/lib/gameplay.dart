import 'package:flutter/material.dart';
import 'package:ultratrivia/questions.dart';
//import 'package:link/link.dart';
//import 'dart:io';
//import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'signin.dart';
import 'user.dart';
import 'package:flip_card/flip_card.dart';
import 'globals.dart' as globals;

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class GamePlayPage extends StatefulWidget {
  @override
  GamePlay createState() {
    return new GamePlay();
  }
}

class GamePlay extends State<GamePlayPage> {
  //List<String> usedQuestions = new List<String>();
  String usedQuestions = '0';
  Future<Questions> futureQuestion;

  @override
  void initState() {
    fetchQuestion(globals.category, usedQuestions);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Ultra Trivia',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: new FlipCard(
          key: cardKey,
          flipOnTouch: false,
          front: Container(
            width: 500,
            height: 1400,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 120),
            child: Column(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: FutureBuilder<Questions>(
                            future: futureQuestion,
                            builder: (context, question) {
                              if (question.hasData) {
                                usedQuestions = '${question.data.qNum}';
                                return Text(
                                  '${question.data.question}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                              } else if (question.hasError)
                                return Text(
                                  "${question.error}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                );

                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            new SizedBox(
                              width: 300.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                                color: Colors.deepPurpleAccent,
                                child: const Text('This is Answer #1'),
                                onPressed: () {/* ... */},
                              ),
                            ),
                            const SizedBox(height: 10),
                            new SizedBox(
                              width: 300.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                                color: Colors.deepPurpleAccent,
                                child: const Text('This is Answer #2'),
                                onPressed: () {/* ... */},
                              ),
                            ),
                            const SizedBox(height: 10),
                            new SizedBox(
                              width: 300.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                                color: Colors.deepPurpleAccent,
                                child: const Text('This is Answer #3'),
                                onPressed: () {/* ... */},
                              ),
                            ),
                            const SizedBox(height: 10),
                            new SizedBox(
                              width: 300.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                                color: Colors.deepPurpleAccent,
                                child: const Text('This is Answer #4'),
                                onPressed: () {
                                  cardKey.currentState.toggleCard();
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          back: Container(
            width: 400,
            height: 1400,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 120),
            child: Column(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          //leading: Icon(Icons.stop),
                          title: Center(
                            child: Text(
                              'Incorrect',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          //subtitle: Text('Trivia Question?'),
                        ),
                        FlatButton(
                          child: Text('Try Again'),
                          onPressed: () {
                            cardKey.currentState.toggleCard();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
