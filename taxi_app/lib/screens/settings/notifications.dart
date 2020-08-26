import 'package:flutter/material.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/mobile_notification.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/settings/notifications_settings.dart';

import '../../constants.dart';

class Notifications extends StatelessWidget{
  final FlutterDatabase database;
  final Person person;
  final MobileNotification mobileNotification;

  const Notifications(this.database, this.person, this.mobileNotification);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("Mobile Notifications"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Account and Trip Updates', style: TextStyle(fontWeight:  FontWeight.bold),),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new NotificationsSettings(person: person, database: database, isLocation: true, mobileNotification: mobileNotification)));
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
                        "Includes trip status notifications and updates related to riding on your account.",
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
                    title: Text('Discount and News', style: TextStyle(fontWeight:  FontWeight.bold),),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new NotificationsSettings(person: person, database: database, isLocation: false, mobileNotification: mobileNotification)));
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
                        "Includes special offers, recommendations and product updates.",
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
}