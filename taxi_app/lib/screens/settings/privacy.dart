
import 'package:flutter/material.dart';

import '../../constants.dart';

class Privacy extends StatelessWidget{

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
                    title: Text('Location', style: TextStyle(fontWeight:  FontWeight.bold),),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){},
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
                    onTap: (){},
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
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){},
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