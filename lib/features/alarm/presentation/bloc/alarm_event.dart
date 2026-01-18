part of 'alarm_bloc.dart';

abstract class AlarmEvent extends Equatable {
  const AlarmEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadAlarms extends AlarmEvent {
  const LoadAlarms();
}

class AddAlarm extends AlarmEvent {
  const AddAlarm(this.item);

  final Alarm item;

  @override
  List<Object?> get props => <Object?>[item];
}
