import 'package:reminder/cores/hive/hive_key.dart' show IHiveKey;

enum ReminderHiveKey with IHiveKey {
  data('data');

  const ReminderHiveKey(this.key);

  static String box = 'reminders';

  @override
  final String key;
}
