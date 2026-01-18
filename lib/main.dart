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
import 'package:reminder/cores/bloc_observer.dart' show AppBlocObserver;
import 'package:reminder/cores/hive/hive_box_registry.dart' show AppHiveBox;
import 'package:reminder/cores/logger.dart' show AppLogger;
import 'package:reminder/cores/themes/data/theme.hive_key.dart'
    show ThemeHiveKey;
import 'package:reminder/features/alarm/data/alarm.hive_key.dart'
    show AlarmHiveKey;
import 'package:reminder/features/alarm/data/models/alarm_model.dart'
    show AlarmModel, AlarmModelAdapter;

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
      await Future.wait(<Future<void>>[
        AppHiveBox.create<dynamic>(ThemeHiveKey.box),
        AppHiveBox.create<AlarmModel>(
          AlarmHiveKey.box,
          adapter: AlarmModelAdapter(),
        ),
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
