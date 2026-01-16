import 'dart:async' show runZonedGuarded, unawaited;

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart'
    show
        ColoredBox,
        Colors,
        ErrorWidget,
        WidgetsFlutterBinding,
        debugPrint,
        runApp;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;
import 'package:reminder/app.dart' show App;
import 'package:reminder/core/bloc_observer.dart' show AppBlocObserver;
import 'package:reminder/core/hive/hive_box_registry.dart'
    show AppHiveBox, HiveBoxRegistry;
import 'package:reminder/core/logger.dart' show AppLogger;
import 'package:reminder/core/themes/data/theme.hive_key.dart'
    show ThemeHiveKey;

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      if (kReleaseMode) {
        ErrorWidget.builder = (_) =>
            const ColoredBox(color: Colors.transparent);
      }
      unawaited(
        SystemChrome.setPreferredOrientations(<DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]),
      );

      Bloc.observer = const AppBlocObserver();
      await HiveBoxRegistry.register(<AppHiveBox<dynamic>>[
        AppHiveBox<String>(ThemeHiveKey.box),
      ]);

      runApp(const App());
    },
    (Object exception, StackTrace stackTrace) {
      try {
        AppLogger.i.fatal('$exception\n$stackTrace');
      } catch (_) {
        debugPrint('$exception\n$stackTrace');
      }
    },
  );
}
