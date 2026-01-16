import 'package:flutter/material.dart' show ThemeData;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode, AppThemeModeTools;

class AppThemeBuilder {
  const AppThemeBuilder();

  static ThemeData from(AppThemeMode mode) => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: mode.color.background.value,
    colorScheme: .fromSeed(seedColor: mode.color.primary.value),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
