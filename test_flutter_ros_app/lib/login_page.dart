import 'package:flutter/widgets.dart';
import 'package:get_ip/get_ip.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:testflutterrosapp/constants.dart';
import 'package:testflutterrosapp/Widgets/get_robot_parameter_textfield.dart';
import 'package:testflutterrosapp/map_real_time.dart';
import 'package:testflutterrosapp/navigation_page.dart';
import 'Routes/transition_route_observer.dart';
import 'arrow_teleop.dart';


class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TransitionRouteAware{
  String _ip = 'Unknown';

  bool _rememberState = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
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
    if (!mounted) return;

    setState(() {
      _ip = ipAddress;
    });
  }
  Widget checkBoxRobotInfo(){
    return Container(
      height: 20.0,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberState,
              checkColor: Colors.blue,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberState = value;
                });
              },
            ),
          ),
          Text("Is it a TurtleBot2 ?", style: kLabelStyle,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
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
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Save and Rescue",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 30.0),
                  GetRobotParameter(
                    fieldName: "Robot IP",
                    icon: Icons.lock_outline,
                    hintText: "Enter the ip of the robot",
                  ),

                  /*
                  SizedBox(height:30),
                  GetRobotParameter(
                    fieldName: "Robot Model",
                    icon: Icons.laptop_chromebook,
                    hintText: "Enter the model of your robot",
                  ),
                  */
                  HowFindRobotIP(),
                  checkBoxRobotInfo(),
                  SizedBox(height: 30.0),
                  SubmitButton(
                      pageName: "Robot Teleoperation",
                      routeName: ArrowTeleop.routeName
                  ),
                  SubmitButton(
                      pageName: "Navigation Control",
                      routeName: NavigationPage.routeName
                  ),
                  SubmitButton(
                      pageName: "Map Observation",
                      routeName: MapRealTime.routeName
                  ),
                //Text("Ip value is $_ip")
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}

class SubmitButton extends StatelessWidget {
  final String robotIP;
  final String deviceIP;
  final String routeName;
  final String pageName;
  const SubmitButton({
    this.robotIP,
    this.deviceIP,
    this.routeName,
    this.pageName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.pushNamed(
              context,
              this.routeName,
              arguments: RobotAndDeviceIP(robotIP: this.robotIP, deviceIP: this.deviceIP));
          print("Ip of the device is ${this.deviceIP}");
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Text(this.pageName,
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
        ),
      ),

    );
  }
}

class HowFindRobotIP extends StatelessWidget {
  const HowFindRobotIP({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => null,
        child: Text(
          "How find robot ip ?",
          style: kLabelStyle,
        ),
      ),
    );
  }
}

class RobotAndDeviceIP {
  String robotIP;
  String deviceIP;
  RobotAndDeviceIP({this.robotIP, this.deviceIP});
}
