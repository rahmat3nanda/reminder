import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:reminder/features/reminder/domain/entities/reminder_time.dart'
    show ReminderTime;

part 'reminder_add_state.dart';

class ReminderAddCubit extends Cubit<ReminderAddState> {
  ReminderAddCubit({required bool use24Format})
    : super(
        ReminderAddState(
          hour: DateTime.now().hour,
          minute: DateTime.now().minute,
          use24Format: use24Format,
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
}
