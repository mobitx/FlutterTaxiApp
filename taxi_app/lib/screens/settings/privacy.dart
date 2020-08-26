
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/mobile_notification.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/settings/notifications_settings.dart';
import 'package:taxiapp/screens/welcome/welcome_screen.dart';

import '../../constants.dart';
import 'notifications.dart';

class Privacy extends StatelessWidget{
  final FlutterDatabase database;
  final Person person;
  final MobileNotification mobileNotification;

  const Privacy(this.database, this.person, this.mobileNotification);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("Privacy"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Turn off Location', style: TextStyle(fontWeight:  FontWeight.bold),),
                    onTap: (){
                      showDialog(
                        context: context, child:
                      new AlertDialog(
                        title: Text("Turn off Location Sharing"),
                        content: Text("Go to your device settings of Taxi App, tap Permissions, then turn off location access"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("CANCEL"),
                            onPressed: (){Navigator.pop(context);},
                          ),
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                              AppSettings.openLocationSettings();
                            },
                          )
                        ],
                      ),
                      );
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
                        "Update your location sharing preferences.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Notifications', style: TextStyle(fontWeight:  FontWeight.bold),),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Notifications(database, person, mobileNotification)));
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
                        "Control what messages you receive from us.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Align(
              alignment: Alignment.centerLeft,
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Delete Your Account', style: TextStyle(fontWeight:  FontWeight.normal, color: Colors.red),),
                      onTap: (){
                        showDialog(
                          context: context, child:
                        new AlertDialog(
                          title: Text("Delete Account"),
                          content: Text("Are you sure you want to delete your account?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("NO"),
                              onPressed: (){Navigator.pop(context);},
                            ),
                            FlatButton(
                              child: Text("YES"),
                              onPressed: () async {
                                var personDao = database.personDao;
                                personDao.deletePerson(person.id);

                                SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                myPrefs.setBool('Login', false);
                                myPrefs.setString('Email', "");

                                Navigator.pushAndRemoveUntil(context,
                                  PageRouteBuilder(pageBuilder: (
                                    BuildContext context, Animation animation,
                                    Animation secondaryAnimation) {
                                        return WelcomeScreen();
                                      },

                                    transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child) {
                                        return new SlideTransition(
                                          position: new Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero,).animate(animation),
                                          child: child,
                                        );
                                      }
                                ),
                                (Route route) => false);
                              },
                            )
                          ],
                        ),
                        );
                      },
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
}