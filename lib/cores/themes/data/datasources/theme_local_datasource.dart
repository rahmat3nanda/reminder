import 'package:hive/hive.dart' show Box;
import 'package:reminder/cores/themes/data/datasources/theme_datasource.dart'
    show ThemeDatasource;
import 'package:reminder/cores/themes/data/theme.hive_key.dart'
    show ThemeHiveKey;
import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode;

class ThemeLocalDatasource implements ThemeDatasource {
  const ThemeLocalDatasource(this.box);

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
