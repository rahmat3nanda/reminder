import 'package:hive/hive.dart';
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;

part 'reminder_model.g.dart';

@HiveType(typeId: 1)
class ReminderModel {
  const ReminderModel({
    required this.id,
    required this.hour,
    required this.minute,
    this.label,
    this.repeatDays = const <int>[],
    this.snoozeMinutes,
    this.enabled = true,
  });

  factory ReminderModel.fromEntity(Reminder reminder) => ReminderModel(
    id: reminder.id,
    hour: reminder.time.hour,
    minute: reminder.time.minute,
    label: reminder.label,
    repeatDays: reminder.repeatDays.map((Day e) => e.value).toList(),
    snoozeMinutes: reminder.snoozeMinutes,
    enabled: reminder.enabled,
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

  Reminder toEntity() => Reminder(
    id: id,
    time: ReminderTime(hour: hour, minute: minute),
    label: label,
    repeatDays: repeatDays.map(Day.fromInt).toList(),
    snoozeMinutes: snoozeMinutes,
    enabled: enabled,
  );
}
