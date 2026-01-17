import 'package:flutter/material.dart'
    show AppBarTheme, IconThemeData, ThemeData;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode, AppThemeModeTools;

class AppThemeBuilder {
  const AppThemeBuilder();

  static ThemeData from(AppThemeMode mode) => ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.inter(),
      iconTheme: IconThemeData(color: mode.color.text.value),
    ),
    scaffoldBackgroundColor: mode.color.background.value,
    colorScheme: .fromSeed(
      seedColor: mode.color.primary.value,
      brightness: mode.brightness,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
