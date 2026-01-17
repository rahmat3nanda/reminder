part of 'alarm_add_cubit.dart';

class AlarmAddState extends Equatable {
  const AlarmAddState({
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

  AlarmTime get alarmTime => AlarmTime(hour: hour, minute: minute);

  AlarmAddState copyWith({int? hour, int? minute, bool? use24Format}) =>
      AlarmAddState(
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        use24Format: use24Format ?? this.use24Format,
      );

  @override
  List<Object> get props => <Object>[hour, minute, use24Format];
}
