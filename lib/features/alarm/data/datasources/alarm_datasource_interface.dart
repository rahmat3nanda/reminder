import 'package:reminder/features/alarm/domain/entities/alarm.dart' show Alarm;

abstract class AlarmDatasource {
  const AlarmDatasource();

  Future<List<Alarm>?> get();

  Future<int> save(Alarm item);
}
