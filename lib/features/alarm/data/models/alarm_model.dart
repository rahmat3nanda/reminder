import 'package:hive/hive.dart';
import 'package:reminder/features/alarm/domain/entities/alarm.dart' show Alarm;
import 'package:reminder/features/alarm/domain/entities/alarm_time.dart'
    show AlarmTime;
import 'package:reminder/features/alarm/domain/enums/day.dart' show Day;

part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel {
  const AlarmModel({
    required this.hour,
    required this.minute,
    this.label,
    this.repeatDays = const <int>[],
    this.snoozeMinutes,
  });

  factory AlarmModel.fromEntity(Alarm alarm) => AlarmModel(
    hour: alarm.time.hour,
    minute: alarm.time.minute,
    label: alarm.label,
    repeatDays: alarm.repeatDays.map((Day e) => e.value).toList(),
    snoozeMinutes: alarm.snoozeMinutes,
  );

  @HiveField(0)
  final int hour;

  @HiveField(1)
  final int minute;

  @HiveField(2)
  final String? label;

  @HiveField(3)
  final List<int> repeatDays;

  @HiveField(4)
  final int? snoozeMinutes;

  Alarm toEntity() => Alarm(
    time: AlarmTime(hour: hour, minute: minute),
    label: label,
    repeatDays: repeatDays.map(Day.fromInt).toList(),
    snoozeMinutes: snoozeMinutes,
  );
}
