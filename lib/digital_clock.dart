library flutter_clock;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock/digital_clock_painter.dart';

class DigitalClock extends StatefulWidget {
  final DateTime? datetime;
  final bool showTicks;
  final bool showSeconds;
  final bool useMilitaryTime;
  final Color hoursColor;
  final Color minutesColor;
  final Color secondsColor;
  final Color separatorColor;
  final Color meridiemColor;
  final bool isLive;
  final double textScaleFactor;
  final double width;
  final double height;
  final BoxDecoration decoration;

  const DigitalClock(
      {this.datetime,
      this.showTicks = true,
      this.showSeconds = true,
      this.useMilitaryTime = false,
      this.hoursColor = Colors.black,
      this.minutesColor = Colors.black,
      this.secondsColor = Colors.black,
      this.separatorColor = Colors.black,
      this.meridiemColor = Colors.black,
      this.textScaleFactor = 2.0,
      this.width = double.infinity,
      this.height = double.infinity,
      this.decoration = const BoxDecoration(),
      isLive,
      Key? key})
      : this.isLive = isLive ?? (datetime == null),
        super(key: key);

  const DigitalClock.dark(
      {datetime,
      showTicks = true,
      showSecondHand = true,
      useMilitaryTime = false,
      width = double.infinity,
      height = double.infinity,
      decoration = const BoxDecoration(),
      Key? key})
      : this(
            datetime: datetime,
            showTicks: showTicks,
            showSeconds: showSecondHand,
            useMilitaryTime: useMilitaryTime,
            width: width,
            height: height,
            hoursColor: Colors.white,
            minutesColor: Colors.white,
            secondsColor: Colors.white,
            separatorColor: Colors.white,
            meridiemColor: Colors.white,
            decoration: decoration,
            key: key);

  @override
  _DigitalClockState createState() => _DigitalClockState(datetime);
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime initialDatetime; // to keep track of time changes
  DateTime datetime;
  Duration updateDuration = const Duration(seconds: 1); // repaint frequency
  _DigitalClockState(datetime)
      : this.datetime = datetime ?? DateTime.now(),
        initialDatetime = datetime ?? DateTime.now();

  initState() {
    super.initState();
    // repaint the clock every second if second-hand or digital-clock are shown
    updateDuration = widget.showSeconds
        ? Duration(seconds: 1)
        : Duration(minutes: 1);

    if (widget.isLive) {
      // update clock every second or minute based on second's visibility.
      Timer.periodic(updateDuration, update);
    }
  }

  update(Timer timer) {
    if (mounted) {
      // update is only called on live clocks. So, it's safe to update datetime.
      this.datetime = this.initialDatetime.add(updateDuration * timer.tick);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      child: Center(
          child: AspectRatio(
              aspectRatio: 1.0,
              child: new Container(
                  constraints: BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                  width: double.infinity,
                  child: new CustomPaint(
                    painter: new DigitalClockPainter(
                        datetime: datetime,
                        showTicks: widget.showTicks,
                        showSeconds: widget.showSeconds,
                        useMilitaryTime: widget.useMilitaryTime,
                        hoursColor: widget.hoursColor,
                        minutesColor: widget.minutesColor,
                        secondsColor: widget.secondsColor,
                        separatorColor: widget.separatorColor,
                        meridiemColor: widget.meridiemColor,
                        textScaleFactor: widget.textScaleFactor),
                  )))),
    );
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.isLive && widget.datetime != oldWidget.datetime) {
      datetime = widget.datetime ?? DateTime.now();
    }
  }
}
