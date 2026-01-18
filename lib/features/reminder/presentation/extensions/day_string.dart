import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;

extension DayString on Day {
  String get name => switch (this) {
    Day.monday => 'Monday',
    Day.tuesday => 'Tuesday',
    Day.wednesday => 'Wednesday',
    Day.thursday => 'Thursday',
    Day.friday => 'Friday',
    Day.saturday => 'Saturday',
    Day.sunday => 'Sunday',
  };
}
