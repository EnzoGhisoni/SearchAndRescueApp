import 'package:flutter/material.dart';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:ros_nodes/ros_nodes.dart';

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
  var topic = RosTopic('instructions', GeometryMsgsTwist());
  void updateTopic(pose2D) async {
    await client.unregister(topic);

    var publisher = await client.register(topic,
        publishInterval: Duration(milliseconds: 100));
    setState(() {
      topic.msg.linear.x = pose2D.x;
      topic.msg.linear.y = pose2D.y;
    });
  }
  void onTapDown(BuildContext context, TapDownDetails details) {
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
      height: 384,
      width: 384,
      color: Colors.white.withOpacity(0.1),
      child: GestureDetector(
        onTapDown: (TapDownDetails details) => onTapDown(context, details),
        child: new Stack(fit: StackFit.expand, children: <Widget>[
          // Hack to expand stack to fill all the space. There must be a better
          // way to do it.
          new Container(color: Colors.white.withOpacity(0.1)),
          new Positioned(
            child: new Text('x = $goal_posx and y = $goal_posy'),
            left: posx,
            top: posy,
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