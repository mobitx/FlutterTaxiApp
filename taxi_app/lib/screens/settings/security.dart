import 'package:flutter/material.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/login/two_step_verification/two_step_verification_settings.dart';
import 'package:taxiapp/screens/settings/notifications_settings.dart';

import '../../constants.dart';

class Security extends StatefulWidget {
  FlutterDatabase database;
  Person person;

  Security({Key key, this.database, this.person,}) : super(key: key);

  @override
  _SecurityState createState() => new _SecurityState();
}

class _SecurityState extends State<Security>{
  String onOrOff = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      if(widget.person.isTwoStepVerOn){
        onOrOff = "On";
      }else{
        onOrOff = "Off";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("Security"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('2-step verification', style: TextStyle(fontWeight:  FontWeight.bold),),
                    trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(onOrOff),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                    ),
                    onTap: (){
                      _awaitReturnValueFromSecondScreen(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80.0,
              child: Container(
                margin: const EdgeInsets.only(left: 18.0, top: 10.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "When this is on, we'll ask for your password and a "
                            "verification code at sign in for added security.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TwoStepVerificationSettings(widget.person, widget.database)
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if(result != null) {
        if (result) {
          onOrOff = "On";
        } else {
          onOrOff = "Off";
        }
      }
    });
  }
}