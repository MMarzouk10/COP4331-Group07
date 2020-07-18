import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultratrivia/gameplay.dart';
import 'globals.dart' as globals;

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  List<String> images = [
    "assets/images/coding.jpg",
    "assets/images/sports.png",
    "assets/images/history.jpg",
    "assets/images/popculture.jpg",
  ];

  List<String> des = [
    "Coding Trivia",
    "Sports Trivia",
    "History Trivia",
    "Pop Culture Trivia",
  ];

  Widget customcard(String langname, String image, String des) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: () {
          if (langname == "Coding")
            globals.category = "Coding";
          else if (langname == "Sports")
            globals.category = "Sports";
          else if (langname == "History")
            globals.category = "History";
          else
            globals.category = "Pop Culture";

          navigateToGamePlayPage(context);
        },
        child: Material(
          color: Colors.purple[900],
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.purple)),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    langname,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "Alike"),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        centerTitle: true,
        title: Text(
          "UltraTrivia",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: new Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepPurple, Colors.purple])),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              customcard("Coding", images[0], des[0]),
              customcard("Sports", images[1], des[1]),
              customcard("History", images[2], des[2]),
              customcard("Pop Culture", images[3], des[3]),
            ],
          ),
        ),
      ),
    );
  }
}

Future navigateToGamePlayPage(context) async {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => GamePlayPage()));
}
