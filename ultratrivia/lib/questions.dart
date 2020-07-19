import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Questions>> fetchQuestion(String category, usedQuestions) async {
  String input = '{"category":"' +
      category +
      '", "usedQuestions": "' +
      usedQuestions +
      '"}';

  final response = await http.post(
      "https://mernstack-1.herokuapp.com/api/getQuestions",
      body: utf8.encode(input),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName("utf-8"));

  String responseBody = response.body;
  //print(responseBody);
  //print(response.statusCode);

  var questionObjJson = jsonDecode(responseBody)['QuestionArray'] as List;
  List<Questions> questionObj = questionObjJson
      .map((questionJson) => Questions.fromJson(questionJson))
      .toList();

  print(questionObj[0]);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return questionObj;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return throw Exception('Failed to load question');
  }
}

class Questions {
  String question;
  String answerOne;
  String answerTwo;
  String answerThree;
  String answerFour;
  String correctAns;
  String category;

  Questions(
      {this.question,
      this.answerOne,
      this.answerTwo,
      this.answerThree,
      this.answerFour,
      this.correctAns,
      this.category});

  factory Questions.fromJson(dynamic json) {
    return Questions(
      question: json['Question'] as String,
      answerOne: json['Option1'] as String,
      answerTwo: json['Option2'] as String,
      answerThree: json['Option3'] as String,
      answerFour: json['Option4'] as String,
      correctAns: json['Answer'] as String,
      category: json['Category'] as String,
    );
  }

  @override
  String toString() {
    return '{ ${this.question}, ${this.answerOne}, ${this.answerTwo}, ${this.answerThree}, ${this.answerFour}, ${this.correctAns}, ${this.category} }';
  }
}
