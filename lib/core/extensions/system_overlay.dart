import 'dart:ui' show Brightness;

enum AppSystemOverlay { dark, light }

extension AppSystemOverlayBrightness on AppSystemOverlay {
  Brightness get iconBrightness => switch (this) {
    AppSystemOverlay.dark => Brightness.dark,
    AppSystemOverlay.light => Brightness.light,
  };

  Brightness get brightness => switch (this) {
    AppSystemOverlay.dark => Brightness.dark,
    AppSystemOverlay.light => Brightness.light,
  };
}
