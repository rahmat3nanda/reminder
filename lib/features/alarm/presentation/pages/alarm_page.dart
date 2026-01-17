import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Container,
        FloatingActionButton,
        GestureDetector,
        Icon,
        Icons,
        InkWell,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:reminder/cores/navigate.dart' show AppNavigate;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState, ToggleTheme;
import 'package:reminder/features/setting/presentation/pages/setting_page.dart'
    show SettingPage;
import 'package:reminder/shared/widgets.dart'
    show RemUIAppBar, RemUIScaffold, RemUISvg;

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(_) => BlocBuilder<ThemeBloc, ThemeState>(
    builder: (BuildContext context, ThemeState state) => RemUIScaffold(
      appBar: RemUIAppBar(
        trailing: <Widget>[
          GestureDetector(
            onTap: () => AppNavigate.to(context, const SettingPage()),
            child: RemUISvg(
              asset: 'assets/svg/setting.svg',
              color: state.color.text,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: state.color.primary.value,
        child: Icon(Icons.add, color: state.color.text.value),
      ),
      body: Center(
        child: InkWell(
          onTap: () => context.read<ThemeBloc>().add(const ToggleTheme()),
          child: Container(
            padding: const .all(24),
            child: Text(
              state.mode.toString(),
              style: TextStyle(color: state.color.text.value),
            ),
          ),
        ),
      ),
    ),
  );
}
