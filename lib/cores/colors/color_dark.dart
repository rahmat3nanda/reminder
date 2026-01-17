part of 'color.dart';

class AppDarkColor with AppColor {
  const AppDarkColor();

  @override
  AppColorBase get background => const Color(0xFF000000).base;

  @override
  AppColorBase get text => const Color(0xFFFFFFFF).base;

  @override
  AppColorBase get card => const Color(0xFF232323).base;
}
