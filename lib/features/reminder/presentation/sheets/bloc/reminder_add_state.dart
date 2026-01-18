part of 'reminder_add_cubit.dart';

class ReminderAddState extends Equatable {
  const ReminderAddState({
    required this.hour,
    required this.minute,
    required this.use24Format,
  });

  final int hour;
  final int minute;
  final bool use24Format;

  int get hourPickerIndex {
    if (use24Format) return hour;

    final int h12 = hour % 12 == 0 ? 12 : hour % 12;
    return h12 - 1;
  }

  int get minutePickerIndex => minute;

  int get amPmIndex => hour < 12 ? 0 : 1;

  ReminderTime get reminderTime => ReminderTime(hour: hour, minute: minute);

  ReminderAddState copyWith({int? hour, int? minute, bool? use24Format}) =>
      ReminderAddState(
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        use24Format: use24Format ?? this.use24Format,
      );

  @override
  List<Object> get props => <Object>[hour, minute, use24Format];
}
