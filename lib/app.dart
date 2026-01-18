import 'package:flutter/material.dart'
    show AnnotatedRegion, Colors, MaterialApp, StatelessWidget, Widget;
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:reminder/cores/extensions/system_overlay.dart'
    show AppSystemOverlayBrightness;
import 'package:reminder/cores/hive/hive_box_registry.dart' show AppHiveBox;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show LoadTheme, ThemeBloc, ThemeState;
import 'package:reminder/cores/themes/data/datasources/theme_local_datasource.dart'
    show ThemeLocalDatasource;
import 'package:reminder/cores/themes/data/theme.hive_key.dart'
    show ThemeHiveKey;
import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode, AppThemeModeTools;
import 'package:reminder/cores/themes/theme_builder.dart' show AppThemeBuilder;
import 'package:reminder/features/alarm/presentation/pages/alarm_page.dart'
    show AlarmPage;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(_) => BlocProvider<ThemeBloc>(
    create: (_) =>
        ThemeBloc(ThemeLocalDatasource(AppHiveBox(ThemeHiveKey.box).box))
          ..add(const LoadTheme()),
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, ThemeState state) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: state.mode.overlay.iconBrightness,
          statusBarBrightness: state.mode.overlay.brightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: state.mode.overlay.iconBrightness,
        ),
        child: MaterialApp(
          title: 'Reminder',
          themeMode: state.mode.value,
          theme: AppThemeBuilder.from(AppThemeMode.light),
          darkTheme: AppThemeBuilder.from(AppThemeMode.dark),
          home: const AlarmPage(),
        ),
      ),
    ),
  );
}
