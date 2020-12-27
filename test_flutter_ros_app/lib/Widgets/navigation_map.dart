import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ros_nodes/ros_nodes.dart';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:get_ip/get_ip.dart';
import 'package:flutter/services.dart';
import 'package:testflutterrosapp/Widgets/camera.dart';
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

    return Column(
      children: [
        Container(
          height: 250,
          width: 350,
          child: MyWebView(
            title: "TurtleBotView",
            selectedUrl:
            //'http://192.168.1.64:8080/stream?topic=/camera/rgb/image_raw&type=mjpeg&quality=80&width=350&height=350',
            //'http:/'+ robotIP() +':8080/stream?topic=/camera/rgb/image_raw&type=mjpeg&quality=80&width=350&height=350',
            'http:/'+ widget.robotIP +':8080/stream?topic=/image_rectangle&type=mjpeg&quality=80&width=350&height=350',
            //'http:/'+ robotIPX +':8080/stream?topic=/image_topic_modified&type=mjpeg&quality=80&width=350&height=350',
            //'http://192.168.43.145:8080/stream?topic=/people_detect/image&type=mjpeg&quality=100&width=640&height=400&default_transport=compressed',
          ),
        ),
        SizedBox(height: 5.0),
        Stack(
          children: [
            Container(
              height: 250,
              width: 350,
              child: MyWebView(
                title: "TurtleBotMap",
                selectedUrl:
                'http:/'+ widget.robotIP +':8080/stream?topic=/image_from_occupancy&type=mjpeg&quality=80&width=350&height=350',

              ),
            ),
            //WriteLocalizationOnMap(),
            LocalizeTap(),

          ],
        ),
      ],
    );
  }

}

class Goal2D {
  double x;
  double y;
  Goal2D(this.x, this.y);
}


