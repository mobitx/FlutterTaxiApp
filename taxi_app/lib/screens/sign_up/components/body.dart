import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxiapp/components/text_field_container.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/mobile_notification.dart';
import 'package:taxiapp/database/model/person.dart';
import 'package:taxiapp/screens/login/login_screen.dart';

import '../../../constants.dart';
import '../../login/components/background.dart';

class Body extends StatefulWidget {
  @override
  BodyAgain createState() => BodyAgain();
}

class BodyAgain extends State<Body> {
  //  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  String _name;
  String _email;
  String _mobile;
  String _password;
  FlutterDatabase database;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height * 0.03,),
            Form(
              key: _formKey,
              child: formUI(),
            ),
          ]
        ),
      ),
    );
  }

  Widget formUI() {
    Size size = MediaQuery.of(context).size;

    return new Column(
      children: <Widget>[
        TextFieldContainer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              icon: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            validator: validateName,
            onSaved: (String val) {
              _name = val;
            },
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Mobile',
              icon: Icon(
                Icons.phone_android,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.phone,
            validator: validateMobile,
            onSaved: (String val) {
              _mobile = val;
            },
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(
                Icons.email,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (String val) {
              _email = val;
            },
          ),
        ),
        TextFieldContainer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              icon: Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: validatePassword,
            onSaved: (String val) {
              _password = val;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: kPrimaryColor,
              onPressed: () {
                _validateInputs();
              },
              child: new Text(
                'SIGN UP',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Text forms was validated.
      form.save();
      insertUserToDatabase();
    } else {
      setState(() => _autoValidate = true);
    }
  }

  String validateName(String value) {
    if (value.trim().length < 3)
      return 'Name must be more than 2 characters';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return 'Password must be more than 6 characters';
    else
      return null;
  }

  String validateMobile(String value) {
  // Indian Mobile number are of 10 digit only
    if (value.trim().length != 10)
      return "Mobile number must be 10 digits";
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim()))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<void> insertUserToDatabase() async{
    WidgetsFlutterBinding.ensureInitialized();

    final database = await $FloorFlutterDatabase
        .databaseBuilder('flutter_database.db')
        .build();

    var personDao = database.personDao;
    var notificationDao = database.notificationDao;
    var userAvailable = await personDao.findPersonByEmail(_email);
    var id = 0;

    if(userAvailable == null){
      var persons = await personDao.findAllPersons();
      if(persons.length > 0 ) {
        id = persons[persons.length-1].id + 1;
      }
      var person = Person(id, _email, _password, _name, _mobile, false);
      await personDao.insertPerson(person);
      var notification = MobileNotification(id, id, true, true);
      await notificationDao.insertNotification(notification);

      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Sign up successful!")));

      Navigator.pushAndRemoveUntil(context,
          PageRouteBuilder(pageBuilder: (
              BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return LoginScreen();
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
    }else{
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("User already available!")));
    }
  }
}