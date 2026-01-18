import 'package:reminder/cores/hive/hive_key.dart' show IHiveKey;

enum AlarmHiveKey with IHiveKey {
  data('data');

  const AlarmHiveKey(this.key);

  static String box = 'alarms';

  @override
  final String key;
}
