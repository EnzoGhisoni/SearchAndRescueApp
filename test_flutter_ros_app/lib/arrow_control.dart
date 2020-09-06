import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ros_nodes/ros_nodes.dart';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:get_ip/get_ip.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class ArrowController extends StatefulWidget {

  GeometryMsgsTwist msg;

  @override
  _ArrowControllerState createState() => _ArrowControllerState();
}

class _ArrowControllerState extends State<ArrowController> {
  GeometryMsgsTwist msg = GeometryMsgsTwist();
  double speed = 2;
  bool _buttonPressed = false;
  bool _loopActive = false;
  /*@override
  Future<void> initState() async {
    super.initState();
    const String ip = await initPlatformState();

  }*/




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
      await Future.delayed(Duration(milliseconds: 200));
    }
    setState(() {
      topic.msg.linear.x = 0;
      topic.msg.angular.z = 0;
    });
    _loopActive = false;
  }

  Future<String> initPlatformState() async {
    String _ip;
    String ipAddress;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ipAddress = await GetIp.ipAddress;
    } on PlatformException {
      ipAddress = 'Failed to get ipAddress.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return '';

    setState(() {
      _ip = ipAddress;
    });
    print("Ip Address:  $_ip");
    return _ip;
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      child: Card(
        elevation: 10,
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
                padding(),
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
      ),
    );
  }

}
Padding padding() {
  return new Padding(padding: EdgeInsets.only(right: 70.7));

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