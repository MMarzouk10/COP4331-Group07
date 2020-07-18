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
  Future<Questions> futureAnswers;
  String res, resAction;

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
                                child: Center(
                                  child: FutureBuilder<Questions>(
                                    future: futureAnswers,
                                    builder: (context, answerOne) {
                                      if (answerOne.hasData) {
                                        usedQuestions =
                                            '${answerOne.data.qNum}';
                                        return Text(
                                          '${answerOne.data.answerOne}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        );
                                      } else if (answerOne.hasError)
                                        return Text(
                                          "${answerOne.error}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        );

                                      return Text(
                                          "Answer #1"); //CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    res = "Correct";
                                    resAction = "Next Question";
                                    cardKey.currentState.toggleCard();
                                  });
                                },
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
                                child: Center(
                                  child: FutureBuilder<Questions>(
                                    future: futureAnswers,
                                    builder: (context, answerTwo) {
                                      if (answerTwo.hasData) {
                                        usedQuestions =
                                            '${answerTwo.data.qNum}';
                                        return Text(
                                          '${answerTwo.data.answerTwo}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        );
                                      } else if (answerTwo.hasError)
                                        return Text(
                                          "${answerTwo.error}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        );

                                      return Text(
                                          "Answer #2"); //CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    res = "Incorrect";
                                    resAction = "Try Again";
                                    cardKey.currentState.toggleCard();
                                  });
                                },
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
                                child: Center(
                                  child: FutureBuilder<Questions>(
                                    future: futureAnswers,
                                    builder: (context, answerThree) {
                                      if (answerThree.hasData) {
                                        usedQuestions =
                                            '${answerThree.data.qNum}';
                                        return Text(
                                          '${answerThree.data.answerThree}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        );
                                      } else if (answerThree.hasError)
                                        return Text(
                                          "${answerThree.error}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        );

                                      return Text(
                                          "Answer #3"); //CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    res = "Incorrect";
                                    resAction = "Try Again";
                                    cardKey.currentState.toggleCard();
                                  });
                                },
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
                                child: Center(
                                  child: FutureBuilder<Questions>(
                                    future: futureAnswers,
                                    builder: (context, answerFour) {
                                      if (answerFour.hasData) {
                                        usedQuestions =
                                            '${answerFour.data.qNum}';
                                        return Text(
                                          '${answerFour.data.answerFour}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        );
                                      } else if (answerFour.hasError)
                                        return Text(
                                          "${answerFour.error}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        );

                                      return Text(
                                          "Answer #4"); //CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    res = "Incorrect";
                                    resAction = "Try Again";
                                    cardKey.currentState.toggleCard();
                                  });
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
