import 'package:reminder/features/alarm/domain/entities/alarm_time.dart'
    show AlarmTime;
import 'package:reminder/features/alarm/domain/enums/day.dart' show Day;

class Alarm {
  const Alarm({
    required this.time,
    this.label,
    this.repeatDays = const <Day>[],
    this.snoozeMinutes,
  });

  final AlarmTime time;
  final String? label;
  final List<Day> repeatDays;
  final int? snoozeMinutes;
}
