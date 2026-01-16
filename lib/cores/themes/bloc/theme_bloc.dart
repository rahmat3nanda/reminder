import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:reminder/cores/themes/data/theme_local_datasource.dart'
    show ThemeLocalDataSource;
import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode, AppThemeModeTools;

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this.local) : super(const ThemeState(AppThemeMode.light)) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
  }

  final ThemeLocalDataSource local;

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final AppThemeMode? savedTheme = await local.get();

    if (savedTheme != null) {
      emit(ThemeState(savedTheme));
      return;
    }

    final AppThemeMode theme = AppThemeMode.os();
    await local.save(theme);
    emit(ThemeState(theme));
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final AppThemeMode next = state.mode.toggle;
    await local.save(next);
    emit(ThemeState(next));
  }
}
