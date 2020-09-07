import 'package:flutter/material.dart';
import 'package:roslib/roslib.dart';
import 'package:testflutterrosapp/Routes/transition_route_observer.dart';
import 'Widgets/arrow_control.dart';
import 'Widgets/camera.dart';
import 'package:testflutterrosapp/login_page.dart';

import 'Widgets/navigation_map.dart';
class NavigationPage extends StatefulWidget {
  NavigationPage({Key key}) : super(key: key);
  static const routeName = '/navigation';
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with TransitionRouteAware{
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
        title: Text('TurtleBot Navigation'),
      ),
      body: Stack(
          children:
          [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  )
              ),
              child: Column(
                children: <Widget>[
                  NavigationMap(),
                ],
              ),
            ),
          ]

      ),
    );
  }
}