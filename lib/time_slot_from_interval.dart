// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'controller/day_part_controller.dart';
import 'controller/language_controller.dart';
import 'model/time_slot_Interval.dart';
import 'widget/time_slot_grid_view.dart';

class TimesSlotGridViewFromInterval extends StatefulWidget {
  /// init time to sected.
  ///
  /// ```dart
  /// initTime: Datetime.now()
  /// ```
  final DateTime initTime;

  /// time slot interval
  ///
  /// ```dart
  /// timeSlotInterval: TimeSlotInterval(
  ///   start : TimeOfDay(hour: 15, minute: 0), // 3:00pm
  ///   end : TimeOfDay(hour: 22, minute: 0), // 10:00pm,
  ///   interval : Duration(minutes: 45),
  /// )
  /// ```
  final TimeSlotInterval timeSlotInterval;

  /// to get selection time
  ///
  /// ```dart
  /// onChange: (selectTime){
  /// print(selectTime.toString())
  /// }
  /// ```
  final ValueChanged<DateTime> onChange;

  /// locale of time
  /// we have two type 'ar' or 'en'
  /// ```dart
  /// locale: 'en' ,//default value
  /// ```
  final String locale;

  /// icon of card time
  ///
  /// ```dart
  /// icon: Icons.access_time,
  /// ```
  final IconData? icon;

  /// color of selected card time
  ///
  /// ```dart
  /// selectedColor: Colors.blue,
  /// ```
  final Color? selectedColor;

  /// color of unselected card time
  ///
  /// ```dart
  /// unSelectedColor: Colors.white,
  /// ```
  final Color? unSelectedColor;

  /// cross axis count of gridview
  ///
  /// ```dart
  /// crossAxisCount: 3, //default value
  /// ```
  final int crossAxisCount;

  const TimesSlotGridViewFromInterval({
    super.key,
    required this.initTime,
    required this.onChange,
    required this.timeSlotInterval,
    this.locale = "en",
    this.crossAxisCount = 3,
    this.icon,
    this.selectedColor,
    this.unSelectedColor,
  });

  @override
  State<TimesSlotGridViewFromInterval> createState() =>
      _TimesSlotGridViewFromIntervalState();
}

class _TimesSlotGridViewFromIntervalState
    extends State<TimesSlotGridViewFromInterval> {
  /// to access DayPartController
  DayPartController dayPartController = DayPartController();
  LocaleController? localeController;

  final List<DateTime> listTimes = [];

  @override
  void initState() {
    super.initState();
    localeController = LocaleController(locale: widget.locale);

    Future.delayed(Duration.zero, () {
      fullDataList();
    });
  }

  void fullDataList() {
    ///difference in hours
    final double differenceHours =
        convertTimeOfDayToDoubel(widget.timeSlotInterval.end) -
            convertTimeOfDayToDoubel(widget.timeSlotInterval.start);
    final double differenceMinute = differenceHours * 60;

    /// get count interval to for loop iteration
    final int countInterval =
        (differenceMinute / widget.timeSlotInterval.interval.inMinutes).round();

    for (int i = 0; i < countInterval; i++) {
      setState(() {
        listTimes.add(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            widget.timeSlotInterval.start.hour,
            widget.timeSlotInterval.start.minute,
          ).add(widget.timeSlotInterval.interval * i),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TimeSlotGridView(
      initTime: widget.initTime,
      onChange: widget.onChange,
      listDates: listTimes,
      locale: widget.locale,
      crossAxisCount: widget.crossAxisCount,
      icon: widget.icon,
      selectedColor: widget.selectedColor,
      unSelectedColor: widget.unSelectedColor,
    );
  }

  double convertTimeOfDayToDoubel(TimeOfDay timeOfDay) {
    return double.parse("${timeOfDay.hour}.${timeOfDay.minute}");
  }
}
