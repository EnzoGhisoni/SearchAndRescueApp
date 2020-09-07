import 'dart:ui';

import 'package:flutter/material.dart';


class WriteLocalizationOnMap extends StatefulWidget {
  @override
  _WriteLocalizationOnMapState createState() => _WriteLocalizationOnMapState();
}
class _WriteLocalizationOnMapState extends State<WriteLocalizationOnMap>
    with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Container(
      height: 384,
      width:384,
      child: CustomPaint(
        painter: ShapePainter(),
        child: Container(
            color: Colors.white.withOpacity(0.1)
        ),
      ),
    );
  }
}
class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..strokeWidth = 10;
    //list of points
    var points = [Offset(0, 0)];
    //draw points on canvas
    canvas.drawPoints(PointMode.points, points, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}