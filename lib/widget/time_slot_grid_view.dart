// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import '../export.dart';

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

  /// to allow sellect the formating of display shapes
  /// groupingWithDayPart -> Display by group by day part with display title of day part
  /// groupingWitouthDayPart -> Display by group by day part without display title of day part
  /// ungrouping -> Display all time without grouping
  ///
  /// ```dart
  /// displayDayPart: DisplayType.groupingWithDayPart, //default value
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
    required this.multiSelection,
    required this.displayType,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childAspectRatio,
    required this.disabledColor,
    required this.disabledTimeSlots,
    required this.disabledTextColor,
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
    if (widget.displayType == DisplayType.groupingWithDisplayDayPart ||
        widget.displayType == DisplayType.groupingWitoutDisplayDayPart) {
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
                    widget.displayType == DisplayType.groupingWithDisplayDayPart
                        ?
                        // tiltle
                        ListTile(
                            title: Text(
                              localeController!
                                  .translate(slotTimes.keys.toList()[index]),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            contentPadding: EdgeInsets.zero,
                          )
                        : SizedBox(
                            height: widget.mainAxisSpacing,
                          ),
                    _buildTimeGrid(
                        listTimes: listTimes,
                        physics: const NeverScrollableScrollPhysics()),
                  ],
                );
        },
      );
    } else {
      List<DateTime> listTimes = [];
      slotTimes.values.toList().forEach((item) {
        listTimes.addAll(item);
      });

      listTimes.sort();
      return _buildTimeGrid(listTimes: listTimes);
    }
  }

  Widget _buildTimeGrid({
    required List<DateTime> listTimes,
    ScrollPhysics? physics,
  }) {
    return GridView.builder(
      physics: physics,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: listTimes.length,
      itemBuilder: (context, i) {
        final DateTime time = listTimes[i];
        return TimeItemCard(
          locale: widget.locale,
          selectedColor: widget.selectedColor,
          unSelectedColor: widget.unSelectedColor,
          disabledColor: widget.disabledColor,
          disabledTextColor: widget.disabledTextColor,
          icon: widget.icon,
          isSelected: checkIsSelected(time),
          isDisabled: checkIsDisabled(time),
          time: time,
          onChange: (value) {
            checkSelectTime(value);
          },
        );
      },
    );
  }

  void checkSelectTime(DateTime value) {
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

  bool checkIsDisabled(DateTime value) {
    return (widget.disabledTimeSlots ?? [])
        .where((item) => item.hour == value.hour && item.minute == value.minute)
        .toList()
        .isNotEmpty;
  }
}
