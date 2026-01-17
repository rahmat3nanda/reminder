import 'package:flutter/material.dart'
    show BuildContext, Expanded, ListView, Row, StatelessWidget, Switch, Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState, ToggleTheme;
import 'package:reminder/cores/themes/domain/theme_mode_enum.dart'
    show AppThemeMode;
import 'package:reminder/shared/widgets.dart'
    show RemUIAppBar, RemUIScaffold, RemUIText;

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(_) => RemUIScaffold(
    appBar: const RemUIAppBar(
      child: RemUIText('Settings', fontWeight: .w600, fontSize: 18),
    ),
    body: ListView(
      padding: const .symmetric(vertical: 12, horizontal: 16),
      children: <Widget>[
        _itemView(
          title: 'Dark mode',
          value: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (BuildContext context, ThemeState s) => Switch(
              value: s.mode == AppThemeMode.dark,
              onChanged: (_) =>
                  context.read<ThemeBloc>().add(const ToggleTheme()),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _itemView({required String title, Widget? value}) => Row(
    children: <Widget>[
      Expanded(child: RemUIText(title, fontWeight: .w400, fontSize: 16)),
      if (value != null) value,
    ],
  );
}
