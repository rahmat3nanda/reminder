import 'package:flutter/material.dart'
    show
        AppBar,
        PreferredSizeWidget,
        Size,
        SizedBox,
        StatelessWidget,
        Widget,
        kToolbarHeight;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:reminder/cores/colors/color.dart' show AppColorBase;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState;

class RemUIAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RemUIAppBar({
    super.key,
    this.child = const SizedBox.shrink(),
    this.height = kToolbarHeight,
    this.backgroundColor,
  });

  final Widget child;
  final double height;
  final AppColorBase? backgroundColor;

  @override
  Widget build(_) => BlocBuilder<ThemeBloc, ThemeState>(
    builder: (_, ThemeState s) => AppBar(
      title: child,
      backgroundColor: backgroundColor?.value ?? s.color.background.value,
    ),
  );

  @override
  Size get preferredSize => Size.fromHeight(height);
}
