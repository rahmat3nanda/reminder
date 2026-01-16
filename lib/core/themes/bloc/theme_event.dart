part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}
