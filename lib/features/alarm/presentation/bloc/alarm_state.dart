part of 'alarm_bloc.dart';

class AlarmState extends Equatable {
  factory AlarmState({required List<Alarm> data}) => AlarmState._(_sort(data));

  const AlarmState._(this.data);

  final List<Alarm> data;

  static List<Alarm> _sort(List<Alarm> alarms) {
    final List<Alarm> list = List<Alarm>.from(alarms);

    list.sort((Alarm a, Alarm b) {
      final int aMinutes = a.time.hour * 60 + a.time.minute;
      final int bMinutes = b.time.hour * 60 + b.time.minute;
      return aMinutes.compareTo(bMinutes);
    });

    return list;
  }

  AlarmState copyWith({List<Alarm>? data}) =>
      AlarmState(data: data ?? this.data);

  @override
  List<Object?> get props => <Object?>[data];
}
