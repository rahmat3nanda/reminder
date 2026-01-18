part of 'reminder_form_cubit.dart';

class ReminderFormState extends Equatable {
  const ReminderFormState({
    required this.hour,
    required this.minute,
    required this.use24Format,
    required this.repeatDays,
    required this.label,
    required this.snooze,
    required this.snoozeExpand,
    required this.snoozeMinutes,
    required this.enabled,
    this.initial,
  });

  final Reminder? initial;
  final int hour;
  final int minute;
  final bool use24Format;
  final List<Day> repeatDays;
  final String? label;
  final bool snooze;
  final bool snoozeExpand;
  final int? snoozeMinutes;
  final bool enabled;

  bool get isEdit => initial != null;

  int get hourPickerIndex {
    if (use24Format) return hour;

    final int h12 = hour % 12 == 0 ? 12 : hour % 12;
    return h12 - 1;
  }

  int get minutePickerIndex => minute;

  int get amPmIndex => hour < 12 ? 0 : 1;

  Reminder get data {
    final Reminder base =
        initial ??
        Reminder.create(
          time: ReminderTime(hour: hour, minute: minute),
          label: label,
          repeatDays: repeatDays,
          snoozeMinutes: snoozeMinutes,
        );

    return base.copyWith(
      time: ReminderTime(hour: hour, minute: minute),
      label: label,
      repeatDays: repeatDays,
      snoozeMinutes: snoozeMinutes,
      enabled: enabled,
    );
  }

  ReminderFormState copyWith({
    Reminder? initial,
    int? hour,
    int? minute,
    bool? use24Format,
    List<Day>? repeatDays,
    String? label,
    bool? snooze,
    bool? snoozeExpand,
    int? snoozeMinutes,
    bool? enabled,
  }) => ReminderFormState(
    initial: initial ?? this.initial,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    use24Format: use24Format ?? this.use24Format,
    repeatDays: repeatDays ?? this.repeatDays,
    label: label ?? this.label,
    snooze: snooze ?? this.snooze,
    snoozeExpand: snoozeExpand ?? this.snoozeExpand,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    enabled: enabled ?? this.enabled,
  );

  @override
  List<Object?> get props => <Object?>[
    initial,
    hour,
    minute,
    use24Format,
    repeatDays,
    label,
    snooze,
    snoozeExpand,
    snoozeMinutes,
    enabled,
  ];
}
