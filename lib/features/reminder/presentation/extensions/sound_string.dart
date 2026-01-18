import 'package:reminder/features/reminder/domain/enums/sound.dart' show Sound;

extension SoundString on Sound {
  String get display => switch (this) {
    Sound.none => 'Default OS',
    Sound.atmosphere => 'Atmosphere',
    Sound.beep => 'Beep',
    Sound.bell => 'Bell',
    Sound.bermuda => 'Bermuda',
    Sound.biohazard => 'Biohazard',
    Sound.classic => 'Classic',
    Sound.funny => 'Funny',
    Sound.incoming => 'Incoming',
    Sound.ticking => 'Ticking',
  };
}
