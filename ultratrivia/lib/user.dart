import 'package:http/http.dart' as http;
import 'dart:convert';

Future<SetPoints> sendPoints(String email, int points) async {
  String input =
      '{"email":"' + email + '", "addVal": "' + points.toString() + '"}';

  final response = await http.post(
      "https://mernstack-1.herokuapp.com/api/incrementPoints",
      body: utf8.encode(input),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName("utf-8"));

  print(response.body);

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

  print(response.body);

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
  final int points;

  GetPoints({this.email, this.points});

  factory GetPoints.fromJson(Map<String, dynamic> json) {
    return GetPoints(
      //email: json['email'] as String,
      points: json['Points'],
    );
  }
}

class SetPoints {
  final String email;
  final int points;

  SetPoints({this.email, this.points});

  factory SetPoints.fromJson(Map<String, dynamic> json) {
    return SetPoints(
      email: json['Email'] as String,
      points: json['Points'],
    );
  }
}
