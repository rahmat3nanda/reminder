import 'package:reminder/core/hive/hive_key.interface.dart' show IHiveKey;

enum ThemeHiveKey with IHiveKey {
  mode('mode');

  const ThemeHiveKey(this.key);

  static String box = 'theme';

  @override
  final String key;
}
