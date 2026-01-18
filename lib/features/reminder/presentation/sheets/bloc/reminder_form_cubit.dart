import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;
import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;

part 'reminder_form_state.dart';

class ReminderFormCubit extends Cubit<ReminderFormState> {
  ReminderFormCubit({required bool use24Format})
    : super(
        ReminderFormState(
          hour: DateTime.now().hour,
          minute: DateTime.now().minute,
          use24Format: use24Format,
          repeatDays: const <Day>[],
          label: null,
          snooze: false,
          snoozeExpand: false,
          snoozeMinutes: null,
          enabled: true,
        ),
      );

  void setHourFromPicker(int index) {
    if (state.use24Format) {
      emit(state.copyWith(hour: index));
      return;
    }

    final bool isPm = state.hour >= 12;
    final int h12 = index + 1;
    final int h24 = (h12 % 12) + (isPm ? 12 : 0);

    emit(state.copyWith(hour: h24));
  }

  void setMinute(int minute) => emit(state.copyWith(minute: minute));

  void setAmPm(int index) {
    if (state.use24Format) return;

    final bool toPm = index == 1;
    final int h12 = state.hour % 12 == 0 ? 12 : state.hour % 12;
    final int h24 = (h12 % 12) + (toPm ? 12 : 0);

    emit(state.copyWith(hour: h24));
  }

  void repeatDay(Day day) {
    final List<Day> days = List<Day>.from(state.repeatDays);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }

    emit(state.copyWith(repeatDays: days));
  }

  void setLabel(String label) => emit(state.copyWith(label: label));

  void toggleSnooze() {
    emit(
      state.copyWith(
        snooze: !state.snooze,
        snoozeMinutes: state.snoozeMinutes == null ? 10 : null,
      ),
    );
  }

  void toggleSnoozeExpand() {
    emit(state.copyWith(snoozeExpand: !state.snoozeExpand));
  }

  void setSnoozeMinutes(int minutes) {
    emit(state.copyWith(snoozeMinutes: minutes));
  }
}
