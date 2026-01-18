import 'package:equatable/equatable.dart' show Equatable;
import 'package:reminder/features/alarm/domain/entities/alarm_time.dart'
    show AlarmTime;
import 'package:reminder/features/alarm/domain/enums/day.dart' show Day;
import 'package:uuid/uuid.dart' show Uuid;

class Alarm extends Equatable {
  const Alarm({
    required this.id,
    required this.time,
    this.label,
    this.repeatDays = const <Day>[],
    this.snoozeMinutes,
    this.enabled = true,
  });

  factory Alarm.create({
    required AlarmTime time,
    String? label,
    List<Day> repeatDays = const <Day>[],
    int? snoozeMinutes,
  }) => Alarm(
    id: const Uuid().v4(),
    time: time,
    label: label,
    repeatDays: repeatDays,
    snoozeMinutes: snoozeMinutes,
  );

  final String id;
  final AlarmTime time;
  final String? label;
  final List<Day> repeatDays;
  final int? snoozeMinutes;
  final bool enabled;

  Alarm copyWith({
    AlarmTime? time,
    String? label,
    List<Day>? repeatDays,
    int? snoozeMinutes,
    bool? enabled,
  }) => Alarm(
    id: id,
    time: time ?? this.time,
    label: label ?? this.label,
    repeatDays: repeatDays ?? this.repeatDays,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    enabled: enabled ?? this.enabled,
  );

  @override
  List<Object?> get props => <Object?>[
    id,
    time,
    label,
    repeatDays,
    snoozeMinutes,
    enabled,
  ];
}
