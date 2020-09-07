import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ros_nodes/ros_nodes.dart';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:get_ip/get_ip.dart';
import 'package:flutter/services.dart';
import 'package:testflutterrosapp/Widgets/write_localization_on_map.dart';
import 'dart:math';

import 'package:testflutterrosapp/constants.dart';
import 'package:testflutterrosapp/login_page.dart';

import 'localize_tap.dart';

class NavigationMap extends StatefulWidget {
  final String robotIP;
  final String deviceIP;

  const NavigationMap({
    this.robotIP,
    this.deviceIP,

    Key key,}) : super(key: key);

  @override
  _NavigationMapState createState() => _NavigationMapState();
}

class _NavigationMapState extends State<NavigationMap> {
  //static var ip = RobotAndDeviceIP(robotIP:widget.robotIP, deviceIP:this.widget.deviceIP);
  GeometryMsgsTwist msg = GeometryMsgsTwist();
  double speed = 2;
  Goal2D goal2d;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          height: 384,
          width: 384,
          child: Image(image: AssetImage("assets/images/tb3_house_map.jpg"),),
        ),
        WriteLocalizationOnMap(),
        LocalizeTap(),

      ],
    );
  }

}

class Goal2D {
  double x;
  double y;
  Goal2D(this.x, this.y);
}


