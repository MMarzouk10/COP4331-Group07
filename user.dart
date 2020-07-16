import 'package:http/http.dart' as http;
import 'dart:convert';

Future<User> fetchUser(String username, pass) async {
  String input = '{"login":"' + username + '", "password": "' + pass + '"}';

  final response = await http.post(
      "https://mernstack-1.herokuapp.com/api/login",
      body: utf8.encode(input),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      encoding: Encoding.getByName("utf-8"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

class User {
  final String userName;
  final String userID;

  User({this.userName, this.userID});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['login'].toString(),
      userID: json['id'].toString(),
    );
  }
}
