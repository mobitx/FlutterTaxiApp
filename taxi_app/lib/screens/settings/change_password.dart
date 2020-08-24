import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/components/my_strings.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/person.dart';
import '../../constants.dart';

class ChangePassword extends StatefulWidget {
  final Person person;
  final FlutterDatabase database;

  ChangePassword({Key key, this.person, this.database}) : super(key: key);

  @override
  _ChangePasswordState createState() => new _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  String _password;
  var _passwordController = TextEditingController();
  var _oldPasswordController = TextEditingController();
  var _rePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryLightColor,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Change Password"),
        ),
        body: new Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Form(
            key: _formKey,
            child: new ListView(
                children: <Widget>[
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    controller: _oldPasswordController,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.lock_open,
                        size: 40.0,
                      ),
                      labelText: 'Old Password',
                    ),
                    validator: (String value) =>
                    value != widget.person.password ? Strings.oldPasswordError : null,
                    obscureText: true,
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.lock_outline,
                        size: 40.0,
                      ),
                      labelText: 'New Password',
                    ),
                    onSaved: (String value) {
                      _password = value;
                    },
                    validator: (String value) =>
                    value.length < 6 ? Strings.passwordLengthError : null,
                    obscureText: true,
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new TextFormField(
                    controller: _rePasswordController,
                      decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      icon: const Icon(
                        Icons.lock,
                        size: 40.0,
                      ),
                      labelText: 'Repeat New Password',
                      ),
                    validator: (String value) =>
                    value != _passwordController.text ? Strings.passwordsError : null,
                    obscureText: true,
                  ),
                  new SizedBox(
                    height: 50.0,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: _getSubmitButton(),
                  )
                ],
            ),
          ),
        ),
    );
  }

  Widget _getSubmitButton() {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child: const Text(
          "Change Password",
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    } else {
      return new RaisedButton(
        onPressed: _validateInputs,
        color: kPrimaryColor,
        splashColor: kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(100.0)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
        textColor: Colors.white,
        child: new Text(
          "Change Password".toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
  }

  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }

  void _validateInputs() {
      final FormState form = _formKey.currentState;
      if (!form.validate()) {
          _showInSnackBar('Please fix the errors in red before submitting.');
      } else {
          form.save();
          insertPaymentToDatabase();
      }
  }

  Future<void> insertPaymentToDatabase() async{
    WidgetsFlutterBinding.ensureInitialized();

    var personDao = widget.database.personDao;
    widget.person.password = _password;

    await personDao.updatePerson(widget.person);

    _oldPasswordController.clear();
    _passwordController.clear();
    _rePasswordController.clear();

    _showInSnackBar("Password change successful!");

  }
}