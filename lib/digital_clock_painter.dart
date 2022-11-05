import 'package:flutter/material.dart';

class DigitalClockPainter extends CustomPainter {
  DateTime datetime;
  final bool showTicks;
  final bool showSeconds;
  final bool useMilitaryTime;
  final Color hoursColor;
  final Color minutesColor;
  final Color secondsColor;
  final Color separatorColor;
  final Color meridiemColor;
  final double textScaleFactor;

  static const double BASE_SIZE = 320.0;
  static const double MINUTES_IN_HOUR = 60.0;
  static const double SECONDS_IN_MINUTE = 60.0;
  static const double HOURS_IN_CLOCK = 12.0;
  static const double HAND_PIN_HOLE_SIZE = 8.0;
  static const double STROKE_WIDTH = 3.0;

  DigitalClockPainter(
      {required this.datetime,
      this.showTicks = true,
      this.showSeconds = true,
      this.hoursColor = Colors.black,
      this.minutesColor = Colors.black,
      this.secondsColor = Colors.black,
      this.separatorColor = Colors.black,
      this.meridiemColor = Colors.red,
      this.textScaleFactor = 2.0,
      this.useMilitaryTime = false});

  @override
  void paint(Canvas canvas, Size size) {
    double scaleFactor = size.shortestSide / BASE_SIZE;
    _paintDigitalClock(canvas, size, scaleFactor, useMilitaryTime);
  }

  @override
  bool shouldRepaint(DigitalClockPainter oldDelegate) {
    return oldDelegate.datetime.isBefore(datetime);
  }

  void _paintDigitalClock(
      Canvas canvas, Size size, double scaleFactor, bool useMilitaryTime) {
    int hourInt = datetime.hour;
    String meridiem = '';
    if (!useMilitaryTime) {
      if (hourInt > 12) {
        hourInt = hourInt - 12;
        meridiem = ' PM';
      } else {
        meridiem = ' AM';
      }
    }
    String hour = hourInt.toString().padLeft(2, "0");
    String minute = datetime.minute.toString().padLeft(2, "0");
    String second = datetime.second.toString().padLeft(2, "0");
    TextSpan digitalClockSpan = new TextSpan(
        style: TextStyle(fontSize: 18 * scaleFactor * textScaleFactor),
        children: <TextSpan>[
          new TextSpan(style: TextStyle(color: hoursColor), text: "$hour"),
          new TextSpan(style: TextStyle(color: separatorColor), text: ":"),
          new TextSpan(
              style: TextStyle(color: minutesColor), text: "$minute"),
          new TextSpan(style: TextStyle(color: separatorColor), text: ":"),
          new TextSpan(
              style: TextStyle(color: secondsColor), text: "$second"),
          new TextSpan(
              style: TextStyle(color: meridiemColor), text: "$meridiem")
        ]);
    TextPainter digitalClockTP = new TextPainter(
        text: digitalClockSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    digitalClockTP.layout();
    digitalClockTP.paint(
        canvas,
        size.center(
            -digitalClockTP.size.center(Offset(0.0, 0.0))));
  }
}
