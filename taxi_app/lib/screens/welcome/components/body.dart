import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxiapp/screens/login/login_screen.dart';
import 'package:taxiapp/screens/sign_up/sign_up_screen.dart';
import 'package:taxiapp/components/rounded_button.dart';
import 'package:taxiapp/constants.dart';
import 'package:taxiapp/database/database.dart';
import 'background.dart';

class Body extends StatelessWidget{
  final FlutterDatabase database;

  const Body(this.database);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO ITX TAXI",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height * 0.03,),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.03,),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen(database);
                      },
                    ),
                  );
                },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen(database);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}