part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState(this.mode);

  final AppThemeMode mode;

  @override
  List<Object?> get props => <Object?>[mode];
}
