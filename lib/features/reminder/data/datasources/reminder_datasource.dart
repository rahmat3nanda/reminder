import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;

abstract class ReminderDatasource {
  const ReminderDatasource();

  Future<List<Reminder>?> get();

  Future<void> save(Reminder item);

  Future<void> update(Reminder item);

  Future<void> delete(String id);
}
