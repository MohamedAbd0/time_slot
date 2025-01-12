// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'time_slot.dart';

class TimesSlotGridViewFromList extends StatefulWidget {
  /// init time to sected.
  ///
  /// ```dart
  /// initTime: [Datetime.now()]
  /// ```
  final List<DateTime> initTime;

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
    this.multiSelection = false,
    this.displayType = DisplayType.groupingWithDisplayDayPart,
    this.mainAxisSpacing = 5,
    this.crossAxisSpacing = 5,
    this.childAspectRatio = 3,
    this.disabledColor,
    this.disabledTimeSlots,
    this.disabledTextColor,
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
      multiSelection: widget.multiSelection,
      displayType: widget.displayType,
      mainAxisSpacing: widget.mainAxisSpacing,
      crossAxisSpacing: widget.crossAxisSpacing,
      childAspectRatio: widget.childAspectRatio,
      disabledColor: widget.disabledColor,
      disabledTimeSlots: widget.disabledTimeSlots,
      disabledTextColor: widget.disabledTextColor,
    );
  }
}
