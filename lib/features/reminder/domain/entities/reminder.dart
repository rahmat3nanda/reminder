import 'package:equatable/equatable.dart' show Equatable;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;
import 'package:reminder/features/reminder/domain/enums/sound.dart' show Sound;
import 'package:uuid/uuid.dart' show Uuid;

class Reminder extends Equatable {
  const Reminder({
    required this.id,
    required this.time,
    this.label,
    this.sound = Sound.none,
    this.repeatDays = const <Day>[],
    this.snoozeMinutes,
    this.enabled = true,
    this.delete = false,
  });

  factory Reminder.create({
    required ReminderTime time,
    String? label,
    Sound sound = Sound.none,
    List<Day> repeatDays = const <Day>[],
    int? snoozeMinutes,
  }) => Reminder(
    id: const Uuid().v4(),
    time: time,
    label: label,
    sound: sound,
    repeatDays: repeatDays,
    snoozeMinutes: snoozeMinutes,
  );

  final String id;
  final ReminderTime time;
  final String? label;
  final Sound sound;
  final List<Day> repeatDays;
  final int? snoozeMinutes;
  final bool enabled;
  final bool delete;

  Reminder copyWith({
    ReminderTime? time,
    String? label,
    Sound? sound,
    List<Day>? repeatDays,
    int? snoozeMinutes,
    bool? enabled,
    bool? delete,
  }) => Reminder(
    id: id,
    time: time ?? this.time,
    label: label ?? this.label,
    sound: sound ?? this.sound,
    repeatDays: repeatDays ?? this.repeatDays,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    enabled: enabled ?? this.enabled,
    delete: delete ?? this.delete,
  );

  @override
  List<Object?> get props => <Object?>[
    id,
    time,
    label,
    sound,
    repeatDays,
    snoozeMinutes,
    enabled,
    delete,
  ];
}
