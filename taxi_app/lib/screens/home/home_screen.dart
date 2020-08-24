import 'package:flutter/material.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/navigation/get_discounts.dart';
import 'package:taxiapp/screens/navigation/payment_list.dart';
import 'package:taxiapp/screens/navigation/settings.dart';
import 'package:taxiapp/screens/navigation/your_trips_screen.dart';
import '../../constants.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget{
  final Person person;
  final FlutterDatabase database;

  const HomeScreen(this.person,this.database);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Body(),
      appBar: new AppBar(
        backgroundColor: kPrimaryColor,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                person.name,
                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal),
              ),
              accountEmail: new Text(
                person.email,
                style: TextStyle(color: Colors.white54),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: kPrimaryLightColor,
                child: new Icon(Icons.person),
              ),
            ),
            new ListTile(
              title: new Text(
                'Your Trips',
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new YourTripsScreen()));
              },
            ),
            new ListTile(
              title: new Text(
                'Payment',
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new PaymentList(person: person, database: database)));
              },
            ),
            new ListTile(
              title: new Text(
                'Get Discounts',
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new GetDiscounts()));
              },
            ),
            new ListTile(
              title: new Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Settings(person: person, database: database)));
              },
            ),
          ],
        ),
      ),
    );
  }
}