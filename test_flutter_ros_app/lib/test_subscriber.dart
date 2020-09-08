import 'package:ros_nodes/messages/std_msgs/String.dart';
import 'package:ros_nodes/messages/nav_msgs/Odometry.dart';
import 'package:ros_nodes/ros_nodes.dart';

void main() async {
  var config = RosConfig(
    'ros_nodes_example_node',
    'http://192.168.43.189:11311/',
    '192.168.43.131',
    24125,
  );
  var client = RosClient(config);
  var msg = NavMsgsOdometry();
  var topic = RosTopic('odom', msg);
  await client.unsubscribe(topic);

  var subscriber = await client.subscribe(topic);
  subscriber.onValueUpdate.listen((type) => print('Listener 1: ${type.pose.pose.position.x}'));
  subscriber.onValueUpdate.listen((_) => print('Listener 2: ${msg.pose.pose.position.y}'));
}