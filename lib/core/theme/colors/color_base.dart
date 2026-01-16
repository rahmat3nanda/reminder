part of 'color.dart';

typedef AppColorsBase = List<AppColorBase>;

class AppColorBase {
  const AppColorBase(this.value);

  final Color value;
}

extension _ColorAppwColorBase on Color {
  AppColorBase get base => AppColorBase(this);
}

extension AppwColorToolBase on AppColorBase {
  AppColorBase withOpacity(double opacity) =>
      AppColorBase(value.withValues(alpha: opacity));

  AppColorsBase toColors({int length = 2}) =>
      List<AppColorBase>.generate(length, (_) => this);
}

extension AppColorsToolBase on AppColorsBase {
  List<Color> get values => map((AppColorBase e) => e.value).toList();

  AppColorsBase withOpacity(double opacity) =>
      map((AppColorBase e) => e.withOpacity(opacity)).toList();

  LinearGradient gradient({
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) => LinearGradient(begin: begin, end: end, colors: values);
}
