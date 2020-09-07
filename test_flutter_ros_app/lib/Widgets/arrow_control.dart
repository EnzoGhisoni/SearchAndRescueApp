import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ros_nodes/ros_nodes.dart';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:get_ip/get_ip.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:testflutterrosapp/constants.dart';
import 'package:testflutterrosapp/login_page.dart';

class ArrowController extends StatefulWidget {
  final String robotIP;
  final String deviceIP;
  const ArrowController({
    this.robotIP,
    this.deviceIP,

    Key key,}) : super(key: key);

  @override
  _ArrowControllerState createState() => _ArrowControllerState();
}

class _ArrowControllerState extends State<ArrowController> {
  //static var ip = RobotAndDeviceIP(robotIP:widget.robotIP, deviceIP:this.widget.deviceIP);
  GeometryMsgsTwist msg = GeometryMsgsTwist();
  double speed = 2;
  bool _buttonPressed = false;
  bool _loopActive = false;

  @override
  void initState() {
    super.initState();
  }


  static var config = RosConfig(
    'ros_arrow_key_controller',
    'http://100.88.32.70:11311/',
    '100.88.32.96',
    24125,
  );
  var client = RosClient(config);
  // For the turtlebot3
  //var topic = RosTopic('cmd_vel', GeometryMsgsTwist());

  // For the turtlebot2
  var topic = RosTopic('mobile_base/commands/velocity', GeometryMsgsTwist());
  void onClickMove(move) async {
    await client.unregister(topic);

    var publisher = await client.register(topic,
        publishInterval: Duration(milliseconds: 100));

/*    setState(() {
      topic.msg.linear.x = move.x;
      topic.msg.angular.z = move.rotz;


    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        topic.msg.linear.x = 0;
        topic.msg.angular.z = 0;


      });
    });*/
    if (_loopActive) return;
    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        topic.msg.linear.x = move.x;
        topic.msg.angular.z = move.rotz;
      });
      // wait a bit
      await Future.delayed(Duration(milliseconds: 100));
    }
    setState(() {
      topic.msg.linear.x = 0;
      topic.msg.angular.z = 0;
    });
    _loopActive = false;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: kBoxDecorationArrowControllerStyle,
      width: 350,
      child: Column(
        children: [
          /*RaisedButton(
              onPressed: () {
                onClickMove(Move(speed, 0));
              },
              child: Text('Up')
          ),*/
          Container(
            width: 70,
            child: Listener(
              onPointerDown: (details) {
                _buttonPressed = true;
                onClickMove(Move(speed, 0));
              },
              onPointerUp: (details) {
                _buttonPressed = false;
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.white, border: Border.all()),
                padding: EdgeInsets.all(16.0),
                child: Text('Up', textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Row(
            children: [
              padding(),
              /*RaisedButton(
                  onPressed: () {
              onClickMove(Move(0, -speed));
              },
                  child: Text('Left')
              ),*/
              Container(
                width: 70,
                child: Listener(
                  onPointerDown: (details) {
                    _buttonPressed = true;
                    onClickMove(Move(0, speed));
                  },
                  onPointerUp: (details) {
                    _buttonPressed = false;
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, border: Border.all()),
                    padding: EdgeInsets.all(16.0),
                    child: Text('Left', textAlign: TextAlign.center,),
                  ),
                ),
              ),
              SizedBox(width: 68,),
              Container(
                width: 70,
                child: Listener(
                  onPointerDown: (details) {
                    _buttonPressed = true;
                    onClickMove(Move(0, -speed));
                  },
                  onPointerUp: (details) {
                    _buttonPressed = false;
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, border: Border.all()),
                    padding: EdgeInsets.all(16.0),
                    child: Text('Right', textAlign: TextAlign.center,),
                  ),
                ),
              ),
            ],
          ),
          /*RaisedButton(
              onPressed: () {
                onClickMove(Move(-speed, 0));
              },
              child: Text('Down')
          ),*/

          Container(
            width: 70,
            child: Listener(
              onPointerDown: (details) {
                _buttonPressed = true;
                onClickMove(Move(-speed, 0));
              },
              onPointerUp: (details) {
                _buttonPressed = false;
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.white, border: Border.all()),
                padding: EdgeInsets.all(16.0),
                child: Text('Down', textAlign: TextAlign.center,),
              ),
            ),
          ),
        ],

      ),
    );
  }

}
Padding padding() {
  return new Padding(padding: EdgeInsets.only(left: 71));

}

class Move {
  double x;
  double rotz;
  Move(this.x, this.rotz);
}


// TODO refactor it into widget
/*class CustomControllerButton extends StatefulWidget {
  bool _buttonPressed;
  double speed;
  Function onClickMove;
  String title;
  CustomControllerButton(this._buttonPressed,
      this.speed, this.onClickMove, this.title);
  @override
  _CustomControllerButtonState createState() => _CustomControllerButtonState();
}

class _CustomControllerButtonState extends State<CustomControllerButton> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        onPointerDown: (details) {
          widget._buttonPressed = true;
          widget.onClickMove(Move(widget.speed, 0));
        },
        onPointerUp: (details) {
          widget._buttonPressed = false;
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white, border: Border.all()),
          padding: EdgeInsets.all(16.0),
          child: Text(widget.title),
        ),
      ),
    );
  }
}*/
