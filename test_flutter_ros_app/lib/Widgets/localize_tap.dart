import 'package:flutter/material.dart';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:ros_nodes/ros_nodes.dart';
import 'package:testflutterrosapp/constants.dart';
class LocalizeTap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return new LocalizeTapState();
  }
}
class LocalizeTapState extends State<LocalizeTap> {
  double posx = 100.0;
  double posy = 100.0;
  double goal_posx = 0;
  double goal_posy = 0;
  double scaleX = 20;
  double scaleY = 20;
  //static String robotIP = "100.88.20.14";
  static robotIP() => robotIP_global;
  static deviceIP() => deviceIP_global;
  static var config = RosConfig(
    'ros_tap_map_controller',
    'http://' + robotIP() + ':11311/',
    //'100.88.20.135',
    deviceIP(),
    24125,
  );
  var client = RosClient(config);

  // For the turtlebot2
  var topic = RosTopic('instructions', GeometryMsgsTwist());
  void updateTopic(pose2D) async {
    await client.unregister(topic);

    var publisher = await client.register(topic,
        publishInterval: Duration(milliseconds: 100));
    setState(() {
      topic.msg.linear.x = pose2D.x;
      topic.msg.linear.y = pose2D.y;
    });
    print("xgoal: $pose2D.x and ygoal: $pose2D.y");
  }
  void onTapDown(BuildContext context, TapDownDetails details) async {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      goal_posx = (-posy/scaleX) +10;
      goal_posy = (-posx/scaleY) +10;

    });
    updateTopic(Pose2D(x: goal_posx, y: goal_posy));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      //height: 384,
      //width: 384,
      height: 284,
      width: 384,
      color: Colors.white.withOpacity(0.1),
      child: GestureDetector(
        onTapDown: (TapDownDetails details) => onTapDown(context, details),
        child: new Stack(fit: StackFit.expand, children: <Widget>[
          // Hack to expand stack to fill all the space. There must be a better
          // way to do it.
          new Container(color: Colors.white.withOpacity(0.1)),
          new Positioned(
            //child: new Text('($goal_posx, $goal_posy)'),
            child: new Text('x (${goal_posx.toStringAsFixed(2)}, ${goal_posy.toStringAsFixed(2)})'),
            left: posx - 38,
            top: posy - 38,
          )
        ]),
      ),
    );
  }
}

class Pose2D {
  Pose2D({this.x, this.y});
  double x;
  double y;
}