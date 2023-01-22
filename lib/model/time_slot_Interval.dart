// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TimeSlotInterval {
  final TimeOfDay start;
  final TimeOfDay end;
  final Duration interval;

  const TimeSlotInterval({
    required this.start,
    required this.end,
    required this.interval,
  });
}
