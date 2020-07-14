import 'package:flutter/material.dart';
//import 'package:link/link.dart';
//import 'dart:io';
//import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'signin.dart';
import 'package:flip_card/flip_card.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class GamePlayPage extends StatefulWidget {
  @override
  GamePlay createState() {
    return new GamePlay();
  }
}

class GamePlay extends State<GamePlayPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ultra Trivia'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: new FlipCard(
          key: cardKey,
          flipOnTouch: false,
          front: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
            child: Column(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.query_builder),
                          title: Text('Trivia Question Topic'),
                          subtitle: Text('Trivia Question?'),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 50),
                                RaisedButton(
                                  child: const Text('Answer #1'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 30),
                                RaisedButton(
                                  padding: const EdgeInsets.all(5.0),
                                  child: const Text('Answer #2'),
                                  onPressed: () {/* ... */},
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 50),
                                RaisedButton(
                                  child: const Text('Answer #3'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 30),
                                RaisedButton(
                                    padding: const EdgeInsets.all(5.0),
                                    child: const Text('Answer #4'),
                                    onPressed: () {
                                      cardKey.currentState.toggleCard();
                                    }),
                              ],
                            ),
                            const SizedBox(height: 20),
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
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
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
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          //subtitle: Text('Trivia Question?'),
                        ),
                        FlatButton(
                          child: const Text('Try Again'),
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
