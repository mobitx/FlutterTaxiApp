import 'package:flutter/material.dart';
import 'package:taxiapp/components/text_field_container.dart';
import 'package:taxiapp/constants.dart';

class RoundedInputField extends StatelessWidget{
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.controller,
    this.keyboardType,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}