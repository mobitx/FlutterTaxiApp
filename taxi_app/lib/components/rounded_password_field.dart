import 'package:flutter/material.dart';
import 'package:taxiapp/components/text_field_container.dart';
import 'package:taxiapp/constants.dart';

class RoundedPasswordField extends StatelessWidget{
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const RoundedPasswordField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.controller,
    this.keyboardType,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}