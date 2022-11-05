# Flutter Analog Clock Widget
[![pub package](https://img.shields.io/pub/v/flutter_clock.svg)](https://pub.dartlang.org/packages/flutter_clock)

Clean and fully customizable clock widget.

![Flutter Analog Clock Screenshot](https://github.com/jeffreydwalter/flutter_clock/raw/master/doc/sample_screenshot.png?raw=true)


## Installation

In your `pubspec.yaml` file within your Flutter Project:

```yaml
dependencies:
  flutter_clock: ^0.1.0
```

## Features

- Modern and clean analog clock interface.
- Fully customizable.
- Live clock.
- Custom datetime.

## Usage

```dart
import 'package:flutter_clock/analog_clock.dart';


AnalogClock(
	decoration: BoxDecoration(
	    border: Border.all(width: 2.0, color: Colors.black),
	    color: Colors.transparent,
	    shape: BoxShape.circle),
	width: 150.0,
	isLive: true,
	hourHandColor: Colors.black,
	minuteHandColor: Colors.black,
	showSecondHand: false,
	numberColor: Colors.black87,
	showNumbers: true,
	showAllNumbers: false,
	textScaleFactor: 1.4,
	showTicks: false,
	showDigitalClock: false,
	datetime: DateTime(2019, 1, 1, 9, 12, 15),
	);
```

## Parameters


![Flutter Analog Clock Parameters](https://github.com/jeffreydwalter/flutter_clock/raw/master/doc/visual_doc.png?raw=true)


## Example

Demo app can be found in the [`example/`](https://github.com/jeffreydwalter/flutter_clock/tree/master/example) folder.
