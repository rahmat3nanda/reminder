part of 'reminder_add_cubit.dart';

class ReminderAddState extends Equatable {
  const ReminderAddState({
    required this.hour,
    required this.minute,
    required this.use24Format,
    required this.repeatDays,
    required this.label,
    required this.snoozeMinutes,
    required this.enabled,
  });

  final int hour;
  final int minute;
  final bool use24Format;
  final List<Day> repeatDays;
  final String? label;
  final int? snoozeMinutes;
  final bool enabled;

  int get hourPickerIndex {
    if (use24Format) return hour;

    final int h12 = hour % 12 == 0 ? 12 : hour % 12;
    return h12 - 1;
  }

  int get minutePickerIndex => minute;

  int get amPmIndex => hour < 12 ? 0 : 1;

  ReminderTime get reminderTime => ReminderTime(hour: hour, minute: minute);

  ReminderAddState copyWith({
    int? hour,
    int? minute,
    bool? use24Format,
    List<Day>? repeatDays,
    String? label,
    int? snoozeMinutes,
    bool? enabled,
  }) => ReminderAddState(
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    use24Format: use24Format ?? this.use24Format,
    repeatDays: repeatDays ?? this.repeatDays,
    label: label ?? this.label,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    enabled: enabled ?? this.enabled,
  );

  @override
  List<Object?> get props => <Object?>[
    hour,
    minute,
    use24Format,
    repeatDays,
    label,
    snoozeMinutes,
    enabled,
  ];
}
