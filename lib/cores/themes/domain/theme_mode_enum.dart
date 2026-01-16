import 'dart:io' show Platform;
import 'dart:ui' show Brightness;

import 'package:flutter/material.dart' show ThemeMode, WidgetsBinding;
import 'package:reminder/cores/colors/color.dart'
    show AppColor, AppDarkColor, AppLightColor;
import 'package:reminder/cores/extensions/system_overlay.dart'
    show AppSystemOverlay;

enum AppThemeMode {
  light,
  dark;

  factory AppThemeMode.from(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  factory AppThemeMode.os() => AppThemeMode.from(
    WidgetsBinding.instance.platformDispatcher.platformBrightness,
  );
}

extension AppThemeModeTools on AppThemeMode {
  ThemeMode get value => switch (this) {
    AppThemeMode.dark => ThemeMode.dark,
    AppThemeMode.light => ThemeMode.light,
  };

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

  AppColor get color => switch (this) {
    AppThemeMode.dark => const AppDarkColor(),
    AppThemeMode.light => const AppLightColor(),
  };
}
