import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/screens/login/two_step_verification/otp_screen.dart';
import 'package:taxiapp/screens/login/two_step_verification/two_step_verification_settings.dart';
import 'package:taxiapp/screens/sign_up/sign_up_screen.dart';
import 'package:taxiapp/components/already_have_an_account_check.dart';
import 'package:taxiapp/components/rounded_button.dart';
import 'package:taxiapp/components/rounded_input_field.dart';
import 'package:taxiapp/components/rounded_password_field.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/screens/home/home_screen.dart';
import 'background.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: size.height * 0.03,),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03,),
              RoundedInputField(
                controller: _emailController,
                hintText: "Your Email", icon: Icons.person,
                keyboardType: TextInputType.emailAddress,
              ),
              RoundedPasswordField(
                  controller: _passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  onChanged: (value) {}
              ),
              RoundedButton(
                text: "LOGIN",
                press: () async {
                  if (_emailController.text.isNotEmpty) {
                    FlutterDatabase database = await $FloorFlutterDatabase.databaseBuilder('flutter_database.db').build();

                    final personDao = database.personDao;
                    final notificationDao = database.notificationDao;
                    final result = await personDao.findPersonByEmailAndPassword(
                        _emailController.text, _passwordController.text);
                    if (result != null) {
                      final mobileNotification = await notificationDao.findNotificationByUserId(result.id);
                      if(!result.isTwoStepVerOn) {
                        SharedPreferences myPrefs = await SharedPreferences
                            .getInstance();
                        myPrefs.setBool('Login', true);
                        myPrefs.setString('Email', result.email);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Login Successful!")));
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen(
                                  result, database, mobileNotification);
                            },
                          ),
                        );
                      }else{
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OTPScreen(result, database, mobileNotification);
                            },
                          ),
                        );
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Wrong email or password!")));
                    }
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Empty field!')));
                  }
                },
              ),
              SizedBox(height: size.height * 0.03,),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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