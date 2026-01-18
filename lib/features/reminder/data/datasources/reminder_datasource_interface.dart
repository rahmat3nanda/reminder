import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;

abstract class ReminderDatasource {
  const ReminderDatasource();

  Future<List<Reminder>?> get();

  Future<int> save(Reminder item);
}
