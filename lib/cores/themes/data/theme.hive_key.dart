import 'package:reminder/cores/hive/hive_key.dart' show IHiveKey;

enum ThemeHiveKey with IHiveKey {
  mode('mode');

  const ThemeHiveKey(this.key);

  static String box = 'theme';

  @override
  final String key;
}
