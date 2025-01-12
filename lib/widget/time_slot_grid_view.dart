// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import '../controller/day_part_controller.dart';
import '../controller/language_controller.dart';
import 'time_item_card.dart';

class TimeSlotGridView extends StatefulWidget {
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

  /// to get selections time
  ///
  /// ```dart
  /// onChange: (List<DateTime>> selectTime){
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

  const TimeSlotGridView({
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
  });

  @override
  State<TimeSlotGridView> createState() => _TimeSlotGridViewState();
}

class _TimeSlotGridViewState extends State<TimeSlotGridView> {
  /// to access DayPartController
  DayPartController dayPartController = DayPartController();
  LocaleController? localeController;

  Map<String, List<DateTime>> slotTimes = {};

  List<DateTime> selectionTimes = [];

  @override
  void initState() {
    super.initState();
    localeController = LocaleController(locale: widget.locale);

    selectionTimes = [...widget.initTime];

    Future.delayed(Duration.zero, () {
      setState(() {
        slotTimes =
            dayPartController.getSlotTimesListMap(listDates: widget.listDates);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: slotTimes.keys.length,
      itemBuilder: (context, index) {
        final List<DateTime> listTimes =
            slotTimes[slotTimes.keys.toList()[index]]!;
        return listTimes.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  // tiltle
                  ListTile(
                    title: Text(
                      localeController!
                          .translate(slotTimes.keys.toList()[index]),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),

                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCount,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 3,
                    ),
                    itemCount: listTimes.length,
                    itemBuilder: (context, i) {
                      final DateTime time = listTimes[i];

                      return TimeItemCard(
                        locale: widget.locale,
                        selectedColor: widget.selectedColor,
                        unSelectedColor: widget.unSelectedColor,
                        icon: widget.icon,
                        isSelected: checkIsSelected(time),
                        time: time,
                        onChange: (value) {
                          checkSelectTime(value);
                        },
                      );
                    },
                  )
                ],
              );
      },
    );
  }

  checkSelectTime(DateTime value) {
    if (widget.multiSelection) {
      setState(() {
        if (selectionTimes.contains(value)) {
          selectionTimes.remove(value);
        } else {
          selectionTimes.add(value);
        }
      });
    } else {
      setState(() {
        selectionTimes = [value];
      });
    }
    widget.onChange(selectionTimes);
  }

  bool checkIsSelected(DateTime value) {
    return selectionTimes
        .where((item) => item.hour == value.hour && item.minute == value.minute)
        .toList()
        .isNotEmpty;
  }
}
