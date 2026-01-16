import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode;

abstract class IThemeLocalDataSource {
  const IThemeLocalDataSource();

  Future<AppThemeMode?> get();

  Future<void> save(AppThemeMode mode);
}
