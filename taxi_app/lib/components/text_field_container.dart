import 'package:flutter/material.dart';
import 'package:taxiapp/constants.dart';

class TextFieldContainer extends StatelessWidget{
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29)
      ),
      child: child,
    );
  }
}