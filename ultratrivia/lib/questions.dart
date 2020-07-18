import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Questions> fetchQuestion(String category, usedQuestions) async {
  String input = '{"category":"' +
      category +
      '", "usedQuestions": "' +
      usedQuestions +
      '"}';

  final response = await http.post(
      "https://mernstack-1.herokuapp.com/api/getQuestion",
      body: utf8.encode(input),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName("utf-8"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Questions.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return Questions.fromJson(json.decode(response.body));
    //throw Exception('Failed to load question');
  }
}

class Questions {
  String question;
  String answerOne;
  String answerTwo;
  String answerThree;
  String answerFour;
  String qNum;

  Questions(
      {this.question,
      this.answerOne,
      this.answerTwo,
      this.answerThree,
      this.answerFour,
      this.qNum});

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      question: json['Question'] as String,
      answerOne: json['Option1'] as String,
      answerTwo: json['Option2'].toString(),
      answerThree: json['Option3'].toString(),
      answerFour: json['Option4'].toString(),
      qNum: json['QNUM'].toString(),
    );
  }
}
