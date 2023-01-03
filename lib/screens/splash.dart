import 'dart:async';

import 'package:Mugavan/screens/dashboard.dart';
import 'package:Mugavan/screens/profile.dart';
import 'package:Mugavan/screens/signup.dart';
import 'package:Mugavan/utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getSession();
    startTime();
  }

  Future<void> getSession() async {
    prefs = await SharedPreferences.getInstance();
  }

  startTime() {
    var duration = const Duration(seconds: Constant.duration);
    return Timer(duration, route);
  }

  route() {
    if (prefs.getString('session') != null &&
        prefs.getString('session') == 'AUTHORIZED') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Profile()));
    } else if (prefs.getString('session') != null &&
        prefs.getString('session') == 'UPDATED') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignUp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logo.png',
                        width: 300,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
