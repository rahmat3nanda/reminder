import 'package:flutter/material.dart'
    show Drawer, PreferredSizeWidget, Scaffold, StatelessWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState;

class RemUIScaffold extends StatelessWidget {
  const RemUIScaffold({
    this.body,
    this.appBar,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    this.bottomNavigationBar,
    this.drawer,
    this.background,
    super.key,
  });

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final bool extendBody;
  final Widget? bottomNavigationBar;
  final Drawer? drawer;
  final Widget? background;

  @override
  Widget build(_) => BlocBuilder<ThemeBloc, ThemeState>(
    builder: (_, ThemeState s) => Scaffold(
      key: key,
      backgroundColor: s.color.background.value,
      appBar: appBar,
      drawer: drawer,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    ),
  );
}
