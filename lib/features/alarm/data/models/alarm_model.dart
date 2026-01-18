import 'package:hive/hive.dart';
import 'package:reminder/features/alarm/domain/entities/alarm.dart' show Alarm;
import 'package:reminder/features/alarm/domain/entities/alarm_time.dart'
    show AlarmTime;
import 'package:reminder/features/alarm/domain/enums/day.dart' show Day;

part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel {
  const AlarmModel({
    required this.id,
    required this.hour,
    required this.minute,
    this.label,
    this.repeatDays = const <int>[],
    this.snoozeMinutes,
    this.enabled = true,
  });

  factory AlarmModel.fromEntity(Alarm alarm) => AlarmModel(
    id: alarm.id,
    hour: alarm.time.hour,
    minute: alarm.time.minute,
    label: alarm.label,
    repeatDays: alarm.repeatDays.map((Day e) => e.value).toList(),
    snoozeMinutes: alarm.snoozeMinutes,
    enabled: alarm.enabled,
  );

  @HiveField(0)
  final String id;

  @HiveField(1)
  final int hour;

  @HiveField(2)
  final int minute;

  @HiveField(3)
  final String? label;

  @HiveField(4)
  final List<int> repeatDays;

  @HiveField(5)
  final int? snoozeMinutes;

  @HiveField(6)
  final bool enabled;

  Alarm toEntity() => Alarm(
    id: id,
    time: AlarmTime(hour: hour, minute: minute),
    label: label,
    repeatDays: repeatDays.map(Day.fromInt).toList(),
    snoozeMinutes: snoozeMinutes,
    enabled: enabled,
  );
}
