import 'package:flutter/material.dart';

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
  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      goal_posx = (posx/scaleX) -10;
      goal_posy = (posy/scaleY) -10;
    });
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