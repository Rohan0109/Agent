import 'dart:async';

import 'package:agent_login/people.dart';
import 'package:agent_login/phone_no.dart';
import 'package:agent_login/profile.dart';
import 'package:agent_login/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //use MaterialApp() widget like this

        home: SplashScreen() //create new widget class for this 'home' to
        // escape 'No MediaQuery widget found' error
        );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("accessToken");
    print(await Share_pref().get_accessToken());

    if (prefs.getString("phoneNumber") != null) {
      if (prefs.getBool("isUpdated") == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PeopleWidget()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProfileWidget()));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PhoneNoWidget()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }
}

initScreen(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Text(
            "Splash Screen",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 1,
          )
        ],
      ),
    ),
  );
}
