import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;

extension DayString on Day {
  String get display => switch (this) {
    Day.monday => 'Monday',
    Day.tuesday => 'Tuesday',
    Day.wednesday => 'Wednesday',
    Day.thursday => 'Thursday',
    Day.friday => 'Friday',
    Day.saturday => 'Saturday',
    Day.sunday => 'Sunday',
  };
}

extension DaysString on List<Day> {
  String get display {
    if (isEmpty) return 'Never';

    final Set<Day> set = toSet();

    const List<Day> allDays = Day.values;
    if (set.length == allDays.length && allDays.every(set.contains)) {
      return 'Everyday';
    }

    const List<Day> weekdays = <Day>[
      Day.monday,
      Day.tuesday,
      Day.wednesday,
      Day.thursday,
      Day.friday,
    ];

    if (set.length == weekdays.length && weekdays.every(set.contains)) {
      return 'Weekday';
    }

    const List<Day> weekends = <Day>[Day.saturday, Day.sunday];

    if (set.length == weekends.length && weekends.every(set.contains)) {
      return 'Weekend';
    }

    return map((Day e) => e.display.substring(0, 3)).join(', ');
  }
}
