import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/components/my_strings.dart';
import 'package:taxiapp/database/database.dart';
import 'package:taxiapp/database/model/person.dart';

import '../../constants.dart';

class EditAccountDetails extends StatefulWidget {
  final Person person;
  final FlutterDatabase database;

  EditAccountDetails({Key key, this.person, this.database}) : super(key: key);

  @override
  _EditAccountDetailsState createState() => new _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails>{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();

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
        title: Text("Edit Account Details"),
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
                controller: _nameController..text = widget.person.name,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.person,
                    size: 40.0,
                  ),
                  labelText: 'Name',
                ),
                //initialValue: widget.person.name,
                validator: (String value) =>
                value.isEmpty ? Strings.fieldReq : null,
              ),
              new SizedBox(
                height: 30.0,
              ),
              new TextFormField(
                controller: _emailController..text = widget.person.email,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.email,
                    size: 40.0,
                  ),
                  labelText: 'Email',
                ),
                validator: validateEmail,
              ),
              new SizedBox(
                height: 30.0,
              ),
              new TextFormField(
                controller: _phoneController..text = widget.person.mobile,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.phone_android,
                    size: 40.0,
                  ),
                  labelText: 'Mobile Number',
                ),
                validator: validateMobile,
                keyboardType: TextInputType.phone,
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
          "Submit",
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
          "Submit".toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = _nameController.text + " - " + _emailController.text;
    Navigator.pop(context, textToSendBack);
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

  Future<void> insertPaymentToDatabase() async{
    WidgetsFlutterBinding.ensureInitialized();

    var personDao = widget.database.personDao;
    widget.person.name = _nameController.text;
    widget.person.email = _emailController.text;
    widget.person.mobile = _phoneController.text;

    await personDao.updatePerson(widget.person);

    _showInSnackBar("Account details changed successfully!");
    _sendDataBack(context);
  }
}