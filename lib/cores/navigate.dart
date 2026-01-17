import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, Route, Widget;

part 'page_route/cupertino_no_swipe.page_route.dart';
part 'page_route/material_no_swipe.page_route.dart';

class AppNavigate {
  static Route<T> _build<T>(Widget page, {bool dismissible = true}) {
    if (dismissible) {
      return MaterialPageRoute<T>(builder: (_) => page);
    }

    if (Platform.isIOS) {
      return CupertinoNoSwipePageRoute<T>(builder: (_) => page);
    }

    return MaterialNoSwipePageRoute<T>(builder: (_) => page);
  }

  static Future<T?> to<T>(
    BuildContext context,
    Widget page, {
    bool dismissible = true,
  }) => Navigator.of(context).push(_build<T>(page, dismissible: dismissible));

  static Future<T?> move<T>(
    BuildContext context,
    Widget page, {
    bool dismissible = true,
  }) => Navigator.of(
    context,
  ).pushReplacement(_build<T>(page, dismissible: dismissible));

  static void backToRoot(BuildContext context) =>
      Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
}
