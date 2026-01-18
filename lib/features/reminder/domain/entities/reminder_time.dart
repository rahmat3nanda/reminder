import 'package:equatable/equatable.dart' show Equatable;

class ReminderTime extends Equatable {
  const ReminderTime({required this.hour, required this.minute});

  final int hour;
  final int minute;

  @override
  List<Object?> get props => <Object?>[hour, minute];
}
