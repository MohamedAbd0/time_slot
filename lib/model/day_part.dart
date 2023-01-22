class DayPartInfo {
  final DayParts dayPart;
  final double start;
  final double end;

  const DayPartInfo({
    required this.dayPart,
    required this.start,
    required this.end,
  });
}

enum DayParts { morning, afternoon, evening, night }
