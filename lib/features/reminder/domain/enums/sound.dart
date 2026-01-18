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
  ticking,
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
}
