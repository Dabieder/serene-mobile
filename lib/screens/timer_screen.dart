import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:serene/widgets/serene_drawer.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen({Key key}) : super(key: key);

  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration =
        controller.duration * (controller.isAnimating ? controller.value : 1.0);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 25, seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      drawer: SereneDrawer(),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return CustomPaint(
                                  painter: TimerPainter(
                                      animation: controller,
                                      backgroundColor: Colors.grey[400],
                                      color: themeData.indicatorColor),
                                );
                              },
                            ),
                          ),
                          Align(
                              alignment: FractionalOffset.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "",
                                    style: themeData.textTheme.subtitle1,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      print("Tappy Tap the timer thing");
                                      Duration resultingDuration =
                                          await showDurationPicker(
                                              context: context,
                                              initialTime:
                                                  new Duration(minutes: 30));
                                      controller.duration = resultingDuration;
                                      controller.reset();
                                    },
                                    child: AnimatedBuilder(
                                        animation: controller,
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Text(timerString,
                                              style: themeData
                                                  .textTheme.headline1);
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.reset();
                                      });
                                    },
                                    child: Text(
                                      "Zurücksetzen",
                                      style: themeData.textTheme.subtitle1,
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  )),
            ),
            Container(
                margin: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          controller.reset();
                        });
                      },
                      child: Text(
                        "Löschen",
                        style: themeData.textTheme.subtitle1,
                      ),
                    ),
                    FloatingActionButton(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          return Icon(controller.isAnimating
                              ? Icons.pause
                              : Icons.play_arrow);
                        },
                      ),
                      onPressed: () {
                        if (controller.isAnimating) {
                          controller.stop();
                        } else {
                          controller.reverse(
                              from: controller.value == 0.0
                                  ? 1.0
                                  : controller.value);
                        }
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  static const STROKE_WIDTH = 12.0;

  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = STROKE_WIDTH
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);

    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        backgroundColor != oldDelegate.backgroundColor ||
        color != oldDelegate.color;
  }
}
