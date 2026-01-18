import 'package:hive/hive.dart';
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;
import 'package:reminder/features/reminder/domain/enums/sound.dart' show Sound;

part 'reminder_model.g.dart';

@HiveType(typeId: 1)
class ReminderModel {
  const ReminderModel({
    required this.id,
    required this.hour,
    required this.minute,
    required this.sound,
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
    sound: reminder.sound.name,
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
  final String sound;

  @HiveField(5)
  final List<int> repeatDays;

  @HiveField(6)
  final int? snoozeMinutes;

  @HiveField(7)
  final bool enabled;

  Reminder toEntity() => Reminder(
    id: id,
    time: ReminderTime(hour: hour, minute: minute),
    label: label,
    sound: Sound.fromString(sound),
    repeatDays: repeatDays.map(Day.fromInt).toList(),
    snoozeMinutes: snoozeMinutes,
    enabled: enabled,
  );
}
