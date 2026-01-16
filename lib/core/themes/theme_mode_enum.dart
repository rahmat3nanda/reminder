import 'dart:io' show Platform;
import 'dart:ui' show Brightness;

import 'package:reminder/core/extensions/system_overlay.dart'
    show AppSystemOverlay;

enum AppThemeMode {
  light,
  dark;

  factory AppThemeMode.from(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;
}

extension AppThemeModeTools on AppThemeMode {
  AppThemeMode get toggle => switch (this) {
    AppThemeMode.light => AppThemeMode.dark,
    AppThemeMode.dark => AppThemeMode.light,
  };

  AppSystemOverlay get overlay => switch (this) {
    AppThemeMode.dark =>
      Platform.isIOS ? AppSystemOverlay.dark : AppSystemOverlay.light,
    AppThemeMode.light =>
      Platform.isIOS ? AppSystemOverlay.light : AppSystemOverlay.dark,
  };

  Brightness get brightness => switch (this) {
    AppThemeMode.dark => Brightness.dark,
    AppThemeMode.light => Brightness.light,
  };
}
