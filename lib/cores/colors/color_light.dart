part of 'color.dart';

class AppLightColor with AppColor {
  const AppLightColor();

  @override
  AppColorBase get background => const Color(0xFFFFFFFF).base;

  @override
  AppColorBase get text => const Color(0xFF000000).base;

  @override
  AppColorBase get card => background;
}
