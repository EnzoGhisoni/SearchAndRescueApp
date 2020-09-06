import 'package:flutter/widgets.dart';
import 'package:get_ip/get_ip.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:testflutterrosapp/constants.dart';

class GetRobotParameter extends StatefulWidget {

  final String fieldName;
  final IconData icon;
  final String hintText;
  const GetRobotParameter({
    this.fieldName,
    this.icon,
    this.hintText,
    Key key,}) : super(key: key);
  @override
  GetRobotParameterState createState() => new GetRobotParameterState();
}
class GetRobotParameterState extends State<GetRobotParameter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.fieldName,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                widget.icon,
                color: Colors.white,
              ),
              hintText: widget.hintText,
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }
}
