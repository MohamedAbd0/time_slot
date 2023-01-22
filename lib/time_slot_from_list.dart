// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'controller/day_part_controller.dart';
import 'controller/language_controller.dart';
import 'widget/time_slot_grid_view.dart';

class TimesSlotGridViewFromList extends StatefulWidget {
  /// init time to sected.
  ///
  /// ```dart
  /// initTime: Datetime.now()
  /// ```
  final DateTime initTime;

  /// list of available times
  ///
  /// ```dart
  /// listDates: [Datetime(2023,1,1,8,30),Datetime(2023,1,1,10,30)]
  /// ```
  final List<DateTime> listDates;

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

  const TimesSlotGridViewFromList({
    super.key,
    required this.initTime,
    required this.onChange,
    required this.listDates,
    this.locale = "en",
    this.crossAxisCount = 3,
    this.icon,
    this.selectedColor,
    this.unSelectedColor,
  });

  @override
  State<TimesSlotGridViewFromList> createState() =>
      _TimesSlotGridViewFromListState();
}

class _TimesSlotGridViewFromListState extends State<TimesSlotGridViewFromList> {
  /// to access DayPartController
  DayPartController dayPartController = DayPartController();
  LocaleController? localeController;

  Map<String, List<DateTime>> slotTimes = {};
  @override
  void initState() {
    super.initState();
    localeController = LocaleController(locale: widget.locale);

    Future.delayed(Duration.zero, () {
      setState(() {
        slotTimes =
            dayPartController.getSlotTimesListMap(listDates: widget.listDates);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TimeSlotGridView(
      initTime: widget.initTime,
      onChange: widget.onChange,
      listDates: widget.listDates,
      locale: widget.locale,
      crossAxisCount: widget.crossAxisCount,
      icon: widget.icon,
      selectedColor: widget.selectedColor,
      unSelectedColor: widget.unSelectedColor,
    );
  }
}
