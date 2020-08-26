import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/mobile_notification.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/home/home_screen.dart';
import 'package:taxiapp/screens/welcome/components/background.dart';

class OTPScreen extends StatelessWidget{
  final Person person;
  final FlutterDatabase database;
  final MobileNotification mobileNotification;

  const OTPScreen(this.person,this.database,this.mobileNotification);

  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_top.png",
                      width: size.width * 0.3,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_bottom.png",
                      width: size.width * 0.15,
                    ),
                  ),
                  child(context),
                ],
            ),
          ),
        ],
      ),
    );
  }

  Widget child(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "2-step verification",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: size.height * 0.03,),
        PinEntryTextField(
          onSubmit: (String pin) async{
            if(pin != "1234"){
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Incorrect pin!")));
            }else{
              SharedPreferences myPrefs = await SharedPreferences
                  .getInstance();
              myPrefs.setBool('Login', true);
              myPrefs.setString('Email', person.email);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen(person, database, mobileNotification);
                  },
                ),
              );
            }
          }, // end onSubmit
        ),
      ],
    );
  }

  /*
  Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "2-step verification",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: size.height * 0.03,),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03,),
                Container(
                  child: PinEntryTextField(
                    onSubmit: (String pin){
                      if(pin != "1234"){
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Incorrect pin!")));
                      }else{
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen(person, database, mobileNotification);
                            },
                          ),
                        );
                      }
                    }, // end onSubmit
                  ),
                ),
              ],
          ),
   */
}