import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode;

abstract class ThemeDatasource {
  const ThemeDatasource();

  Future<AppThemeMode?> get();

  Future<void> save(AppThemeMode mode);
}
