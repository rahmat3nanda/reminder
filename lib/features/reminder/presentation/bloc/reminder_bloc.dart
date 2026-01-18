import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:reminder/features/reminder/data/datasources/reminder_datasource.dart';
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc(this.source) : super(ReminderState(data: const <Reminder>[])) {
    on<LoadReminders>(_onLoad);
    on<AddReminder>(_onAdd);
    on<UpdateReminder>(_onUpdate);
    on<DeleteReminder>(_onDelete);
  }

  final ReminderDatasource source;

  Future<void> _onLoad(LoadReminders event, Emitter<ReminderState> emit) async {
    final List<Reminder>? reminders = await source.get();
    emit(ReminderState(data: reminders ?? <Reminder>[]));
  }

  Future<void> _onAdd(AddReminder event, Emitter<ReminderState> emit) async {
    await source.save(event.item);

    emit(ReminderState(data: <Reminder>[...state.data, event.item]));
  }

  Future<void> _onUpdate(
    UpdateReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await source.update(event.item);
    final List<Reminder> reminders = state.data.map((Reminder e) {
      if (e.id == event.item.id) {
        return event.item;
      }
      return e;
    }).toList();
    emit(ReminderState(data: reminders));
  }

  Future<void> _onDelete(
    DeleteReminder event,
    Emitter<ReminderState> emit,
  ) async {
    await source.delete(event.item.id);
    final List<Reminder> reminders = state.data
        .where((Reminder e) => e.id != event.item.id)
        .toList();
    emit(ReminderState(data: reminders));
  }
}
