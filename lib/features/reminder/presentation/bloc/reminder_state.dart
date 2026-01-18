part of 'reminder_bloc.dart';

class ReminderState extends Equatable {
  factory ReminderState({required List<Reminder> data}) =>
      ReminderState._(_sort(data));

  const ReminderState._(this.data);

  final List<Reminder> data;

  static List<Reminder> _sort(List<Reminder> reminders) {
    final List<Reminder> list = List<Reminder>.from(reminders);

    list.sort((Reminder a, Reminder b) {
      final int aMinutes = a.time.hour * 60 + a.time.minute;
      final int bMinutes = b.time.hour * 60 + b.time.minute;
      return aMinutes.compareTo(bMinutes);
    });

    return list;
  }

  ReminderState copyWith({List<Reminder>? data}) =>
      ReminderState(data: data ?? this.data);

  @override
  List<Object?> get props => <Object?>[data];
}
