import 'package:flutter/material.dart';
import 'package:taxiapp/Screens/Welcome/components/body.dart';
import 'package:taxiapp/database/database.dart';

class WelcomeScreen extends StatelessWidget{
  final FlutterDatabase database;

  const WelcomeScreen(this.database);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(database),
    );
  }
}