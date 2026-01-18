import 'package:flutter/material.dart' show BuildContext, MediaQuery;
import 'package:reminder/features/alarm/domain/entities/alarm_time.dart'
    show AlarmTime;

extension AlarmTimeString on AlarmTime {
  String display(BuildContext context) {
    final bool use24Format = MediaQuery.of(context).alwaysUse24HourFormat;

    final String mm = minute.toString().padLeft(2, '0');

    if (use24Format) {
      final String hh = hour.toString().padLeft(2, '0');
      return '$hh:$mm';
    }

    final int h12 = hour % 12 == 0 ? 12 : hour % 12;
    final String hh = h12.toString().padLeft(2, '0');
    final String period = hour < 12 ? 'AM' : 'PM';

    return '$hh:$mm $period';
  }
}
