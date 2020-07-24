import 'package:flutter/material.dart';
import 'package:taxiapp/Screens/Login/components/body.dart';
import 'package:taxiapp/database/database.dart';

class LoginScreen extends StatelessWidget{
  final FlutterDatabase database;

  const LoginScreen(this.database);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(database),
    );
  }
}