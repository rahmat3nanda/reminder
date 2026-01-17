import 'package:flutter/material.dart'
    show
        FontWeight,
        StatelessWidget,
        Text,
        TextAlign,
        TextOverflow,
        TextStyle,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:reminder/cores/colors/color.dart' show AppColorBase;
import 'package:reminder/cores/themes/bloc/theme_bloc.dart'
    show ThemeBloc, ThemeState;

class RemUIText extends StatelessWidget {
  const RemUIText(
    this.text, {
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    super.key,
  });

  final String text;
  final TextAlign? textAlign;
  final AppColorBase? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(_) => BlocBuilder<ThemeBloc, ThemeState>(
    builder: (_, ThemeState s) => Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color?.value ?? s.color.text.value,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    ),
  );
}
