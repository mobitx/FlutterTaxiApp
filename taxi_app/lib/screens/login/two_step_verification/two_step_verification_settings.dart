import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/components/rounded_button.dart';
import 'package:taxiapp/constants.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/person.dart';

class TwoStepVerificationSettings extends StatelessWidget {
  final Person person;
  final FlutterDatabase database;

  const TwoStepVerificationSettings(this.person, this.database);

  @override
  Widget build(BuildContext context) {
    if(person.isTwoStepVerOn){
      return twoStepOn(context);
    }else{
      return twoStepOff(context);
    }
  }

  Widget twoStepOn(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("2-step verification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("2-step verification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Spacer(flex: 2),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text("On",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.greenAccent,
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Delivery Settings",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(flex: 2),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text("Edit",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              )
                          ),
                        ],
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: Text("Codes will be sent to +${person.mobile} via SMS"),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Container(
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Backup Methods",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text("Backup codes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Spacer(flex: 2),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("View",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: Text("Codes will be sent to +${person.mobile} via SMS"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RoundedButton(
                      text: "Turn Off",
                      press: (){
                        _sendDataBack(context, false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendDataBack(BuildContext context, bool status) async {
    var personDao = database.personDao;
    person.isTwoStepVerOn = status;
    await personDao.updatePerson(person);

    Navigator.pop(context, person.isTwoStepVerOn);
  }

  Widget twoStepOff(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        title: Text("2-step verification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(30),
                child: Text("Security beyond your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
              ),
            ),
            SizedBox(height: size.height * 0.03,),
            Image(
              image: new AssetImage("assets/images/2_step.png"),
              height: size.height * 0.3,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(30),
                child: Text("To keep your account more secure, we'll ask you for your password "
                    "and a verification code at sign-in.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(
                text: "Set up now",
                press: (){
                  _sendDataBack(context, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}