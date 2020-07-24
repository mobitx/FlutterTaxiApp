import 'package:flutter/material.dart';
import 'package:taxiapp/screens/sign_up/components/body.dart';
import 'package:taxiapp/database/database.dart';

class SignUpScreen extends StatelessWidget{
  final FlutterDatabase database;

  const SignUpScreen(this.database);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(database)
    );
  }
}