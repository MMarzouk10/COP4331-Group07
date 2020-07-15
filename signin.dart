import 'package:flutter/material.dart';
import 'package:link/link.dart';
import 'dart:io';
//import 'package:http/http.dart' as http;
import 'signup.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:convert';
import 'user.dart';
import 'globals.dart' as globals;

class SignInPage extends StatefulWidget {
  @override
  SignIn createState() {
    return new SignIn();
  }
}

class SignIn extends State<SignInPage> {
  //String serverResponse = 'Server response';
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  Future<User> futureUser;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Ultra Trivia',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
          child: Column(
            children: <Widget>[
              Center(
                child: FutureBuilder<User>(
                  future: futureUser,
                  builder: (context, user) {
                    if (user.hasData) {
                      globals.userID = '${user.data.userID}';
                      globals.userName = '${user.data.userName}';
                      return Text(user.data.userID);
                    } else if (user.hasError) {
                      return Text("${user.error}");
                    }
                    return Text("Server Response");
                  },
                ),
              ),
              Center(
                //alignment: Alignment.center,
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter Username',
                    labelText: 'Username',
                  ),
                ),
              ),
              Center(
                //alignment: Alignment.center,
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Enter Password',
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 120.0, 0.0),
                child: Link(
                  child: Text('Forgot Password?'),
                  url: 'http://www.ultracontacts.com',
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 210.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                futureUser =
                    fetchUser(usernameController.text, passwordController.text);
              });
            },
            label: Text('Sign In'),
            icon: Icon(Icons.thumb_up),
            backgroundColor: Colors.deepPurpleAccent,
          ),
        ),
      ),
    );
  }
}

Future navigateToSignUp(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignUpPage()));
/*_
  signIn(String username, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //var data = {'login': username, 'password': pass};
    var jsonResponse;
    String json = '{"login":"' + username + '", "password": "' + pass + '"}';
    http.Response response = await http.post(
        "https://mernstack-1.herokuapp.com/api/login",
        body: utf8.encode(json),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      final response = await http.get("https://mernstack-1.herokuapp.com/api/login");
      Map userMap = jsonDecode(response.body.toString());
      var user = User.fromJson(userMap);
      serverResponse = "Hello ${user.userName}";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      serverResponse = 'Error: Unable to connect';
    }

    //navigateToSignUp(context);
    //else
    //print("wrong pass");
    if (jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", jsonResponse['token']);

      //Navigator.push(
      //context, MaterialPageRoute(builder: (context) => SignUpPage()));
      //Navigator.of(context).pushAndRemoveUntil(
      //MaterialPageRoute(builder: (BuildContext context) => SignUpPage()),
      //(Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

makeGetRequest() async {
    Response response = await get(_localhost());
    setState(() {
      serverResponse = response.body;
    });
  }

  String _localhost() {
    if (Platform.isAndroid)
      return 'http://10.0.2.2:5000';
    else // for iOS simulator
      return 'http://localhost:5000';
  }*/
}
