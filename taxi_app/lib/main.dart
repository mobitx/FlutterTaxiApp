import 'package:flutter/material.dart';
import 'package:taxiapp/screens/welcome/splash_screen.dart';
import 'package:taxiapp/screens/welcome/welcome_screen.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  //This widget is the root of the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Taxi App',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white
        ),
        home: SplashScreen()
    );
  }
}
