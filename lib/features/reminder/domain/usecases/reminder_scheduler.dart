import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;

abstract class ReminderScheduler {
  Future<void> schedule(Reminder reminder);

  Future<void> cancel(Reminder reminder);
}
