part of 'alarm_bloc.dart';

class AlarmState extends Equatable {
  const AlarmState({required this.data});

  final List<Alarm> data;

  @override
  List<Object?> get props => <Object?>[data];
}
