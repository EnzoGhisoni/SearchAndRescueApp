import 'dart:async';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:ros_nodes/messages/std_msgs/String.dart';
import 'package:ros_nodes/ros_nodes.dart';

void main() async {
  var config = RosConfig(
    'ros_nodes_example_node',
    'http://192.168.1.64:11311/',
    '192.168.1.23',
    24125,
  );
  var client = RosClient(config);
  var topic = RosTopic('cmd_vel', GeometryMsgsTwist());
  await client.unregister(topic);

  var publisher = await client.register(topic,
      publishInterval: Duration(milliseconds: 1000));
  var i = 0;
  Timer.periodic(
    Duration(milliseconds: 500),
        (_) {
      i += 1;
      topic.msg.linear.x = i.toDouble();
    },
  );
}