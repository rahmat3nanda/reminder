import 'package:flutter/material.dart' show Alignment, Color, LinearGradient;

part 'color_base.dart';
part 'color_dark.dart';
part 'color_light.dart';

abstract mixin class AppColor {
  const AppColor();

  AppColorBase get primary => const Color(0xFFFAA12D).base;

  AppColorBase get primaryDark => const Color(0xFFE88B0C).base;

  AppColorBase get primarySoft => const Color(0xFFFFF3E3).base;

  AppColorBase get success => const Color(0xFF22C55E).base;

  AppColorBase get warning => const Color(0xFFF59E0B).base;

  AppColorBase get error => const Color(0xFFEF4444).base;

  AppColorBase get text;

  AppColorBase get background;
}
