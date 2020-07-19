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
  _GamePlay createState() {
    return new _GamePlay();
  }
}

class _GamePlay extends State<GamePlayPage> {
  //List<String> usedQuestions = new List<String>();
  String usedQuestions = '0';
  Future<List<Questions>> futureQuestion;
  Future<List<Questions>> futureAnswers;
  String res = "Incorrect", resAction = "Try Again";
  int i = 0;

  @override
  void initState() {
    futureQuestion = fetchQuestion(globals.category, usedQuestions);
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
            height: 1600,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 120),
            child: Column(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Question Field
                        Center(
                          child: FutureBuilder<List<Questions>>(
                            future: futureQuestion,
                            builder: (context, questionList) {
                              if (questionList.connectionState !=
                                  ConnectionState.done) {
                                return CircularProgressIndicator();
                              }
                              if (questionList.hasError) {
                                return Text(
                                  "${questionList.error}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                );
                              }
                              List<Questions> questions =
                                  questionList.data ?? [];
                              Questions question = questions[i];
                              return Center(
                                child: Text(
                                  question.question,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        FutureBuilder<List<Questions>>(
                          future: futureQuestion,
                          builder: (context, questionList) {
                            if (questionList.connectionState !=
                                ConnectionState.done) {
                              return CircularProgressIndicator();
                            }
                            if (questionList.hasError) {
                              return Text(
                                "${questionList.error}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              );
                            }
                            List<Questions> questions = questionList.data ?? [];
                            Questions question = questions[i];

                            return ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(height: 10),
                                // Answer #1 field
                                new SizedBox(
                                  width: 300.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    color: Colors.deepPurpleAccent,
                                    child: SizedBox(
                                      height: 20.0,
                                      child: Text(
                                        question.answerOne,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Answer #1 Test
                                      if (question.answerOne ==
                                          question.correctAns) {
                                        setState(() {
                                          res = "Correct";
                                          resAction = "Next Question";
                                          Future.delayed(
                                            Duration.zero,
                                            () {
                                              i++;
                                            },
                                          );
                                        });
                                      }
                                      cardKey.currentState.toggleCard();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Answer #2 field
                                new SizedBox(
                                  width: 300.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    color: Colors.deepPurpleAccent,
                                    child: SizedBox(
                                      height: 20.0,
                                      child: Text(
                                        question.answerTwo,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Answer #2 Test
                                      if (question.answerTwo ==
                                          question.correctAns) {
                                        setState(() {
                                          res = "Correct";
                                          resAction = "Next Question";
                                          Future.delayed(
                                            Duration.zero,
                                            () {
                                              i++;
                                            },
                                          );
                                        });
                                      }
                                      cardKey.currentState.toggleCard();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Answer #3 field
                                new SizedBox(
                                  width: 300.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    color: Colors.deepPurpleAccent,
                                    child: SizedBox(
                                      height: 20.0,
                                      child: Text(
                                        question.answerThree,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Answer #3 Test
                                      if (question.answerThree ==
                                          question.correctAns) {
                                        setState(() {
                                          res = "Correct";
                                          resAction = "Next Question";
                                          Future.delayed(
                                            Duration.zero,
                                            () {
                                              i++;
                                            },
                                          );
                                        });
                                      }
                                      cardKey.currentState.toggleCard();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Answer #4 field
                                new SizedBox(
                                  width: 300.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    color: Colors.deepPurpleAccent,
                                    child: SizedBox(
                                      height: 20.0,
                                      child: Text(
                                        question.answerFour,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Answer #4 Test
                                      if (question.answerFour ==
                                          question.correctAns) {
                                        setState(() {
                                          res = "Correct";
                                          resAction = "Next Question";
                                          Future.delayed(
                                            Duration.zero,
                                            () {
                                              i++;
                                            },
                                          );
                                        });
                                      }
                                      cardKey.currentState.toggleCard();
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Rear of Flipped Card. Contains conditional answer response.
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
                        ListTile(
                          //leading: Icon(Icons.stop),
                          title: Center(
                            child: Text(
                              '$res',
                              style: TextStyle(
                                  color: res == "Correct"
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          //subtitle: Text('Trivia Question?'),
                        ),
                        FlatButton(
                          child: Text('$resAction'),
                          onPressed: () {
                            cardKey.currentState.toggleCard();
                            setState(() {
                              Future.delayed(
                                Duration.zero,
                                () {
                                  res = "Inorrect";
                                  resAction = "Try Again";
                                },
                              );
                            });
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
