import 'package:hive/hive.dart' show Box, Hive;
import 'package:reminder/features/reminder/data/datasources/reminder_datasource_interface.dart'
    show ReminderDatasource;
import 'package:reminder/features/reminder/data/models/reminder_model.dart'
    show ReminderModel;
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;

class ReminderLocalDatasource implements ReminderDatasource {
  ReminderLocalDatasource(String box) : box = Hive.box(box);

  final Box<ReminderModel> box;

  @override
  Future<List<Reminder>?> get() async =>
      box.values.map((ReminderModel e) => e.toEntity()).toList();

  @override
  Future<int> save(Reminder item) => box.add(ReminderModel.fromEntity(item));
}
