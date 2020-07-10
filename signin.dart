import 'package:flutter/material.dart';
import 'package:link/link.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SignInPage extends StatefulWidget {
  @override
  SignIn createState() {
    return new SignIn();
  }
}

class SignIn extends State<SignInPage> {
  String serverResponse = 'Server response';
  bool _isLoading = false;
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();

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
          title: Text('Ultra Trivia'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
          child: Column(
            children: <Widget>[
              Center(child: Text(serverResponse)),
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
          padding: const EdgeInsets.symmetric(vertical: 220.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              serverResponse =
                  signIn(usernameController.text, passwordController.text);

              var response = serverResponse ?? "";
              if (response != null) {
                return serverResponse;
              } else {
                return "No Server Response Detected";
              }
            },
            label: Text('Sign In'),
            icon: Icon(Icons.thumb_up),
            backgroundColor: Colors.deepPurpleAccent,
          ),
        ),
      ),
    );
  }

  signIn(String username, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'password': pass};
    var jsonResponse;
    var response = await http
        .post("https://mernstack-1.herokuapp.com/api/login", body: data);
    jsonResponse = json.decode(response.body);
    print(response.body);
    if (jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", jsonResponse['token']);
      //Navigator.of(context).pushAndRemoveUntil(
      //  MaterialPageRoute(builder: (BuildContext context) => SignUpPage()),
      //(Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
      return jsonResponse;
    }
  }

  /*_makeGetRequest() async {
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
