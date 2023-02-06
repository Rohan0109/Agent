import 'package:Mugavan/screens/new_profile.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constant.appName,
        theme: ThemeData(primaryColor: Color.fromRGBO(236, 16, 77, 1)),
        home: Splash(),
      );
    });
  }
}
