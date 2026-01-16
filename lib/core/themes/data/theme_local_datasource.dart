import 'package:hive/hive.dart' show Box;
import 'package:reminder/core/themes/data/theme.hive_key.dart'
    show ThemeHiveKey;
import 'package:reminder/core/themes/data/theme_local_datasource.interface.dart'
    show IThemeLocalDataSource;
import 'package:reminder/core/themes/domain/theme_mode_enum.dart'
    show AppThemeMode;

class ThemeLocalDataSource implements IThemeLocalDataSource {
  const ThemeLocalDataSource(this.box);

  final Box<dynamic> box;

  @override
  Future<AppThemeMode?> get() async {
    final String? value = box.get(ThemeHiveKey.mode.key) as String?;
    if (value == null) return null;

    return AppThemeMode.values.firstWhere((AppThemeMode e) => e.name == value);
  }

  @override
  Future<void> save(AppThemeMode mode) =>
      box.put(ThemeHiveKey.mode.key, mode.name);
}
