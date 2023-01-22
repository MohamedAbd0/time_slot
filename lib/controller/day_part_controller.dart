// ignore_for_file: always_use_package_imports, avoid_classes_with_only_static_members

import '../model/day_part.dart';

class DayPartController {
  final List<DayPartInfo> listDayParts;

  DayPartController({
    this.listDayParts = const [
      DayPartInfo(dayPart: DayParts.morning, start: 5, end: 12),
      DayPartInfo(dayPart: DayParts.afternoon, start: 12, end: 18),
      DayPartInfo(dayPart: DayParts.evening, start: 18, end: 22),
      DayPartInfo(dayPart: DayParts.night, start: 22, end: 5),
    ],
  });

  String getDayPartName({required DayParts dayPart}) {
    return dayPart.toString().split('.').last;
  }

  DayParts? getDayPartOfTime({required DateTime time}) {
    final List<DayPartInfo?> listDayPartInfo = [];

    /// prepare list od day parts
    for (final element in listDayParts) {
      /// normal day part ex: from 4 to 10
      if (element.end > element.start) {
        listDayPartInfo.add(element);
      } else {
        /// composite day part [two day] ex: from 10 to 4
        /// split time to tow parts [from start to 24 , from 0 to end]
        listDayPartInfo.add(
          DayPartInfo(
            dayPart: element.dayPart,
            start: element.start,
            end: 24,
          ),
        );
        listDayPartInfo.add(
          DayPartInfo(
            dayPart: element.dayPart,
            start: 0,
            end: element.end,
          ),
        );
      }
    }

    final DayPartInfo? dayPartInfo = listDayPartInfo.firstWhere(
      (element) => element!.start <= time.hour && element.end > time.hour,
      orElse: () => null,
    );

    return dayPartInfo?.dayPart;
  }

  Map<String, List<DateTime>> getSlotTimesListMap({
    required List<DateTime> listDates,
  }) {
    final Map<String, List<DateTime>> slotTimes = {
      "morning": [],
      "afternoon": [],
      "evening": [],
      "night": []
    };

    for (final element in listDates) {
      /// get day part of time
      final DayParts? dayPart = getDayPartOfTime(time: element);
      if (dayPart != null) {
        /// get day part name of time
        final String dayPartName = getDayPartName(dayPart: dayPart);

        /// full map of slot
        final List<DateTime> list = [element];
        if (slotTimes[dayPartName] != null &&
            slotTimes[dayPartName]!.isNotEmpty) {
          list.addAll(slotTimes[dayPartName]!);
        }

        list.sort();
        slotTimes[dayPartName] = list;
      }
    }

    return slotTimes;
  }
}
