import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;
import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;

extension ReminderNotificationScheduler on Reminder {
  int get baseNotificationId => id.hashCode & 0x7fffffff;

  int notificationId({Day? day, bool snooze = false}) {
    final int dayOffset = day != null ? day.value * 10 : 0;
    final int snoozeOffset = snooze ? 1 : 0;
    return baseNotificationId + dayOffset + snoozeOffset;
  }

  bool get isRepeating => repeatDays.isNotEmpty;

  DateTime nextOccurrence({required Day day, DateTime? from}) {
    final DateTime now = from ?? DateTime.now();

    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    final int diff = (day.value - scheduled.weekday + 7) % 7;
    scheduled = scheduled.add(Duration(days: diff));

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 7));
    }

    return scheduled;
  }

  DateTime nextOneTimeOccurrence({DateTime? from}) {
    final DateTime now = from ?? DateTime.now();

    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}
