import 'package:hive/hive.dart' show Box;
import 'package:reminder/features/alarm/data/datasources/alarm_datasource_interface.dart'
    show AlarmDatasource;
import 'package:reminder/features/alarm/data/models/alarm_model.dart'
    show AlarmModel;
import 'package:reminder/features/alarm/domain/entities/alarm.dart' show Alarm;

class AlarmLocalDatasource implements AlarmDatasource {
  const AlarmLocalDatasource(this.box);

  final Box<AlarmModel> box;

  @override
  Future<List<Alarm>?> get() async =>
      box.values.map((AlarmModel e) => e.toEntity()).toList();

  @override
  Future<int> save(Alarm item) => box.add(AlarmModel.fromEntity(item));
}
