import 'package:flutter/material.dart';
import 'package:roslib/roslib.dart';
import 'package:testflutterrosapp/Routes/transition_route_observer.dart';
import 'package:testflutterrosapp/navigation_page.dart';
import 'Widgets/arrow_control.dart';
import 'arrow_teleop.dart';
import 'Widgets/camera.dart';
import 'login_page.dart';

/*
Launch the terminal commands
$roslaunch turtlebot3_gazebo turtlebot3_world.launch
$roslaunch rosbridge_server rosbridge_websocket.launch
$rosrun web_video_server web_video_server
*/
void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turtlebot Controller',
      home: NavigationPage(),
      navigatorObservers: [TransitionRouteObserver()],
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        ArrowTeleop.routeName: (context) => ArrowTeleop(),
        NavigationPage.routeName: (context) => NavigationPage(),



      },
    );

  }
}
