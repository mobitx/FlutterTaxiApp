import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/mobile_notification.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/constants.dart';
import 'package:taxiapp/screens/settings/change_password.dart';
import 'package:taxiapp/screens/settings/edit_account_details.dart';
import 'package:taxiapp/screens/settings/privacy.dart';
import 'package:taxiapp/screens/settings/security.dart';
import 'package:taxiapp/screens/welcome/welcome_screen.dart';

class Settings extends StatefulWidget {
  final Person person;
  final FlutterDatabase database;
  final MobileNotification mobileNotification;

  Settings({Key key, this.person, this.database, this.mobileNotification}) : super(key: key);

  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings>{
  String name = "", email = "";

  @override
  void initState() {
    super.initState();
    name = widget.person.name;
    email = widget.person.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: new Icon(Icons.person),
                    ),
                    title: Text(name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    subtitle: Text('${email}'),
                    trailing: Icon(Icons.edit),
                    onTap: (){
                      _awaitReturnValueFromSecondScreen(context);
                    },
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: kPrimaryColor,),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ChangePassword(person: widget.person, database: widget.database)));
                    },
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Privacy'),
                    subtitle: Text('Manage the data you share with us'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Privacy(widget.database, widget.person, widget.mobileNotification)));
                    },
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Security'),
                    subtitle: Text('Control your account security with 2-step verification'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Security(database: widget.database, person: widget.person)));
                    },
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Sign Out'),
                    onTap: (){
                      showDialog(
                        context: context, child:
                          new AlertDialog(
                            title: Text("Log Out"),
                            content: Text("Are you sure you want to log out?"),
                            actions: <Widget>[
                                FlatButton(
                                  child: Text("No"),
                                  onPressed: (){Navigator.pop(context);},
                                ),
                                FlatButton(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    SharedPreferences myPrefs = await SharedPreferences.getInstance();
                                    myPrefs.setBool('Login', false);
                                    myPrefs.setString('Email', "");

                                    Navigator.pushAndRemoveUntil(context,
                                        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                                            Animation secondaryAnimation) {
                                              return WelcomeScreen();
                                    }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                                            Animation<double> secondaryAnimation, Widget child) {
                                              return new SlideTransition(
                                                position: new Tween<Offset>(
                                                  begin: const Offset(1.0, 0.0),
                                                  end: Offset.zero,
                                                ).animate(animation),
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
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditAccountDetails(person: widget.person, database: widget.database)
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      //if(result != null) {
        var array = result.toString().split(" - ");
        name = array[0];
        email = array[1];
      //}
    });
  }
}