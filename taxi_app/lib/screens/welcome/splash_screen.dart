import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/screens/home/home_screen.dart';
import 'package:taxiapp/screens/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  var _iconAnimationController;
  var _iconAnimation;
  FlutterDatabase database;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();

    startTimeout();
  }

  void handleTimeout() async{
    var loggedIn = false;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if(myPrefs.getBool('Login') != null) {
      loggedIn = myPrefs.getBool('Login');
      var email = myPrefs.getString('Email');

      if(loggedIn){
        database = await $FloorFlutterDatabase.databaseBuilder('flutter_database.db').build();
        final personDao = database.personDao;
        final notificationDao = database.notificationDao;
        final result = await personDao.findPersonByEmail(email);
        final mobileNotification = await notificationDao.findNotificationByUserId(result.id) ;
        if (result != null) {
          myPrefs.setBool('Login', true);
          myPrefs.setString('Email', result.email);
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => new HomeScreen(result, database, mobileNotification)));
        }else{
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => new WelcomeScreen()));
        }
      }else {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new WelcomeScreen()));
      }
    }else{
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new WelcomeScreen()));
    }
  }

  startTimeout() async {
    var duration = const Duration(seconds: 6);
    return new Timer(duration, handleTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Scaffold(
        body: new Center(
            child: new Image(
              image: new AssetImage("assets/images/batman.jpg"),
              width: _iconAnimation.value * 500,
              height: _iconAnimation.value * 500,
            )),
      ),
    );
  }
}