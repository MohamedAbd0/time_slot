// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeItemCard extends StatelessWidget {
  final bool isSelected;
  final DateTime time;
  final String locale;
  final IconData? icon;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final ValueChanged<DateTime> onChange;
  const TimeItemCard({
    super.key,
    required this.time,
    required this.onChange,
    required this.isSelected,
    required this.locale,
    this.icon,
    this.selectedColor,
    this.unSelectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(time);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor ?? Theme.of(context).primaryColor
              : unSelectedColor ?? Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? Colors.white : null,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            Text(
              DateFormat.jm(locale).format(time),
              style: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
