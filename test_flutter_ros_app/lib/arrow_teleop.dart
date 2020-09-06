import 'package:flutter/material.dart';
import 'package:roslib/roslib.dart';
import 'package:testflutterrosapp/Routes/transition_route_observer.dart';
import 'Widgets/arrow_control.dart';
import 'Widgets/camera.dart';
import 'package:testflutterrosapp/login_page.dart';
class ArrowTeleop extends StatefulWidget {
  ArrowTeleop({Key key}) : super(key: key);
  static const routeName = '/arrow_teleop';
  _ArrowTeleopState createState() => _ArrowTeleopState();
}

class _ArrowTeleopState extends State<ArrowTeleop> with TransitionRouteAware{
  Ros ros;
  Topic chatter;

  @override
  void initState() {
    ros = Ros(url: 'ws://100.88.32.70:9090');
    chatter = Topic(
        ros: ros, name: '/chatter', type: "std_msgs/String", reconnectOnClose: true, queueLength: 10, queueSize: 10);
    super.initState();
  }

  void initConnection() async {
    ros.connect();
    await chatter.subscribe();
    setState(() {});
  }

  void destroyConnection() async {
    await chatter.unsubscribe();
    await ros.close();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    RobotAndDeviceIP ip = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('TurtleBot Controller'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 350,
            width: 350,
            child: MyWebView(
              title: "TurtleBotView",
              selectedUrl:
              //'http://192.168.1.64:8080/stream?topic=/camera/rgb/image_raw&type=mjpeg&quality=80&width=350&height=350',
              'http://100.88.32.70:8080/stream?topic=/camera/rgb/image_raw&type=mjpeg&quality=80&width=350&height=350',
              //'http://192.168.43.145:8080/stream?topic=/people_detect/image&type=mjpeg&quality=100&width=640&height=400&default_transport=compressed',
            ),
          ),

          ArrowController(
            robotIP: ip.robotIP,
            deviceIP: ip.deviceIP,
          ),
        ],
      ),
    );
  }
}