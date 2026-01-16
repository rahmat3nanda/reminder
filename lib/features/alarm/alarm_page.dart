import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Container,
        InkWell,
        Scaffold,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:reminder/core/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState, ToggleTheme;
import 'package:reminder/core/themes/domain/theme_mode_enum.dart'
    show AppThemeModeTools;

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(_) => Scaffold(
    body: Center(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) => InkWell(
          onTap: () => context.read<ThemeBloc>().add(const ToggleTheme()),
          child: Container(
            padding: const .all(24),
            child: Text(
              state.mode.toString(),
              style: TextStyle(color: state.mode.color.text.value),
            ),
          ),
        ),
      ),
    ),
  );
}
