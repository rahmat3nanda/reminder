enum Sound {
  none,
  atmosphere,
  beep,
  bell,
  bermuda,
  biohazard,
  classic,
  funny,
  incoming,
  ticking;

  static Sound fromString(String value) => Sound.values.firstWhere(
    (Sound day) => day.name == value,
    orElse: () => Sound.none,
  );
}

extension SoundResolver on Sound {
  String get android => switch (this) {
    Sound.none => '',
    Sound.atmosphere => 'atmosphere',
    Sound.beep => 'beep',
    Sound.bell => 'bell',
    Sound.bermuda => 'bermuda',
    Sound.biohazard => 'biohazard',
    Sound.classic => 'classic',
    Sound.funny => 'funny',
    Sound.incoming => 'incoming',
    Sound.ticking => 'ticking',
  };

  String get ios => switch (this) {
    Sound.none => '',
    Sound.atmosphere => 'atmosphere.caf',
    Sound.beep => 'beep.caf',
    Sound.bell => 'bell.caf',
    Sound.bermuda => 'bermuda.caf',
    Sound.biohazard => 'biohazard.caf',
    Sound.classic => 'classic.caf',
    Sound.funny => 'funny.caf',
    Sound.incoming => 'incoming.caf',
    Sound.ticking => 'ticking.caf',
  };

  String get preview => switch (this) {
    Sound.none => '',
    Sound.atmosphere => 'assets/sounds/atmosphere.mp3',
    Sound.beep => 'assets/sounds/beep.mp3',
    Sound.bell => 'assets/sounds/bell.mp3',
    Sound.bermuda => 'assets/sounds/bermuda.mp3',
    Sound.biohazard => 'assets/sounds/biohazard.mp3',
    Sound.classic => 'assets/sounds/classic.mp3',
    Sound.funny => 'assets/sounds/funny.mp3',
    Sound.incoming => 'assets/sounds/incoming.mp3',
    Sound.ticking => 'assets/sounds/ticking.mp3',
  };
}
