part of 'reminder_bloc.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadReminders extends ReminderEvent {
  const LoadReminders();
}

class AddReminder extends ReminderEvent {
  const AddReminder(this.item);

  final Reminder item;

  @override
  List<Object?> get props => <Object?>[item];
}
