import 'package:http/http.dart' as http;
import 'dart:convert';

Future<SetPoints> sendPoints(String email, points) async {
  String input = '{"email":"' + email + '", "addVal": "' + points + '"}';

  final response = await http.post(
      "https://mernstack-1.herokuapp.com/api/incrementPoints",
      body: utf8.encode(input),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName("utf-8"));

  print("sendPoints Connection" + '$response.statusCode');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return SetPoints.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

Future<GetPoints> getPoints(String email) async {
  String input = '{"email":"' + email + '"}';

  final response = await http.post(
      "https://mernstack-1.herokuapp.com/api/getPoints",
      body: utf8.encode(input),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName("utf-8"));

  print("getPoints Connection" + '$response.statusCode');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return GetPoints.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

class GetPoints {
  final String email;
  final String points;

  GetPoints({this.email, this.points});

  factory GetPoints.fromJson(Map<String, dynamic> json) {
    return GetPoints(
      email: json['email'].toString(),
      points: json['points'].toString(),
    );
  }
}

class SetPoints {
  final String email;
  final String points;

  SetPoints({this.email, this.points});

  factory SetPoints.fromJson(Map<String, dynamic> json) {
    return SetPoints(
      email: json['email'].toString(),
      //points: json['addVal'].toString(),
    );
  }
}
