# time_slot

 A new Flutter package which helps in creating time slots with given time interval or list of date times and get day part name of time, and this package allow localization ar and en.

[![Pub Version](https://img.shields.io/pub/v/time_slot?logo=flutter&style=for-the-badge)](https://pub.dev/packages/time_slot)


Demo gif
-----
![image](https://github.com/MohamedAbd0/time_slot/blob/main/screenshots/demo.gif)



Installation
-----
1. Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  time_slot: any
```

1. Get the package using your IDE's GUI or via command line with

```bash
$ pub get
```

1. Import the `time_slot.dart` file in your app

```dart
import 'package:time_slot/time_slot.dart';
```

Features
----
- Creating time slots with given time interval
- Creating time slots with given list date times
- Get day part name of time

Usage
-----
DayPartController 
![image](https://github.com/MohamedAbd0/time_slot/blob/main/screenshots/DayPart.png)

```dart
  DayPartController dayPartController = DayPartController();
```
to get day part of time
```dart
  DayParts dayPart = dayPartController.getDayPartOfTime(
    time: DateTime(2023, 1, 1, 10, 30),
  ); ///  DayParts.morning
```
to get day part name from DayParts
```dart
  DayParts dayPart = dayPartController.getDayPartName(dayPart: dayPart),); 
  /// morning
```

TimesSlotGridViewFromInterval
-
to build time slot grid view from interval (10:00 AM to 10:00 PM) every hour

![image](https://github.com/MohamedAbd0/time_slot/blob/main/screenshots/timeSlotFromInterval.png)


```dart
            TimesSlotGridViewFromInterval(
                locale: "en",
                initTime: selectTime,
                crossAxisCount: 4,
                timeSlotInterval: const TimeSlotInterval(
                  start: TimeOfDay(hour: 10, minute: 00),
                  end: TimeOfDay(hour: 22, minute: 0),
                  interval: Duration(hours: 1, minutes: 0),
                ),
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              ),
```

locale = "ar",

```dart
                TimesSlotGridViewFromInterval(
                locale: "ar",
                initTime: selectTime,
                crossAxisCount: 4,
                timeSlotInterval: const TimeSlotInterval(
                  start: TimeOfDay(hour: 10, minute: 00),
                  end: TimeOfDay(hour: 22, minute: 0),
                  interval: Duration(hours: 1, minutes: 0),
                ),
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              ),
```

TimesSlotGridViewFromList
-
to build time slot grid view from list date.

![image](https://github.com/MohamedAbd0/time_slot/blob/main/screenshots/timeSlotFromList.png)


```dart
            TimesSlotGridViewFromList(
                locale: "en",
                initTime: selectTime,
                crossAxisCount: 4,
                listDates: [
                  DateTime(2023, 1, 1, 10, 30),
                  DateTime(2023, 1, 1, 11, 30),
                  DateTime(2023, 1, 1, 12, 30),
                  DateTime(2023, 1, 1, 13, 30),
                  DateTime(2023, 1, 1, 14, 30),
                  DateTime(2023, 1, 1, 15, 30)
                ],
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              ),
```

locale = "ar",

```dart
                TimesSlotGridViewFromList(
                locale: "ar",
                initTime: selectTime,
                crossAxisCount: 4,
                listDates: [
                  DateTime(2023, 1, 1, 10, 30),
                  DateTime(2023, 1, 1, 11, 30),
                  DateTime(2023, 1, 1, 12, 30),
                  DateTime(2023, 1, 1, 13, 30),
                  DateTime(2023, 1, 1, 14, 30),
                  DateTime(2023, 1, 1, 15, 30)
                ],
                onChange: (value) {
                  setState(() {
                    selectTime = value;
                  });
                },
              ),
```


## Contributions
Contributions of any kind are more than welcome! Feel free to fork and improve international_phone_input in any way you want, make a pull request, or open an issue.
