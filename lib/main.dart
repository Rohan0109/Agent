import 'package:Mugavan/screens/splash.dart';
import 'package:Mugavan/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constant.appName,
        theme: ThemeData(
          fontFamily: 'roboto_mono',
          primarySwatch: Constant.primeColor,
          primaryColor: Color.fromRGBO(28, 0, 255, 0.9),
        ),
        home: Splash(),
      );
    });
  }
}
