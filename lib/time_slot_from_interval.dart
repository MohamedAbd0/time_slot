// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'time_slot.dart';

class TimesSlotGridViewFromInterval extends StatefulWidget {
  /// init times to sected.
  ///
  /// ```dart
  /// initTime: [Datetime.now()]
  /// ```
  final List<DateTime> initTime;

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
  final ValueChanged<List<DateTime>> onChange;

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

  /// to allow  Multi Selection
  ///
  /// ```dart
  /// multiSelection: false, //default value
  /// ```
  final bool multiSelection;

  /// to allow sellect the formating of display shapes
  /// groupingWithDisplayDayPart -> Display by group by day part with display title of day part
  /// groupingWitoutDisplayDayPart -> Display by group by day part without display title of day part
  /// ungrouping -> Display all time without grouping
  ///
  /// ```dart
  /// displayDayPart: DisplayType.groupingWithDisplayDayPart, //default value
  /// ```
  final DisplayType displayType;

  /// mainAxisSpacing
  /// ```dart
  /// mainAxisSpacing: 5, //default value
  /// ```
  final double mainAxisSpacing;

  /// crossAxisSpacing
  /// ```dart
  /// crossAxisSpacing: 5, //default value
  /// ```
  final double crossAxisSpacing;

  /// childAspectRatio
  /// ```dart
  /// childAspectRatio: 5, //default value
  /// ```
  final double childAspectRatio;

  /// Color for disabled time section
  /// ```dart
  /// disabledColor: Colors.white,
  /// ```
  final Color? disabledColor;

  /// Color for disabled time section text
  /// ```dart
  /// disabledTextColor: Colors.white,
  /// ```
  final Color? disabledTextColor;

  /// list of disabled times that match timeslots
  ///
  /// ```dart
  /// disabledTimeSlots: [Datetime.now()]
  /// ```
  final List<DateTime>? disabledTimeSlots;

  /// border Radius of slot time card
  ///
  /// ```dart
  /// borderRadius: BorderRadius.circular(5)
  /// ```
  final BorderRadiusGeometry? borderRadius;

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
    this.multiSelection = false,
    this.displayType = DisplayType.groupingWithDisplayDayPart,
    this.mainAxisSpacing = 5,
    this.crossAxisSpacing = 5,
    this.childAspectRatio = 3,
    this.disabledColor,
    this.disabledTimeSlots,
    this.disabledTextColor,
    this.borderRadius,
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
      multiSelection: widget.multiSelection,
      displayType: widget.displayType,
      mainAxisSpacing: widget.mainAxisSpacing,
      crossAxisSpacing: widget.crossAxisSpacing,
      childAspectRatio: widget.childAspectRatio,
      disabledColor: widget.disabledColor,
      disabledTimeSlots: widget.disabledTimeSlots,
      disabledTextColor: widget.disabledTextColor,
      borderRadius: widget.borderRadius,
    );
  }

  double convertTimeOfDayToDoubel(TimeOfDay timeOfDay) {
    return double.parse("${timeOfDay.hour}.${timeOfDay.minute}");
  }
}
