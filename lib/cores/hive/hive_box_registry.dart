import 'package:hive/hive.dart' show Box, Hive, LazyBox, TypeAdapter;
import 'package:hive_flutter/hive_flutter.dart' show HiveX;

bool _hasInit = false;

class AppHiveBox<T> {
  const AppHiveBox(this.name, {this.lazy = false});

  final String name;
  final bool lazy;

  static Future<void> create<T>(
    String name, {
    bool lazy = false,
    TypeAdapter<T>? adapter,
  }) async {
    if (!_hasInit) {
      await Hive.initFlutter();
      _hasInit = true;
    }

    if (adapter != null) {
      Hive.registerAdapter<T>(adapter);
    }

    if (Hive.isBoxOpen(name)) {
      return Future<void>.value();
    }

    if (lazy) {
      await Hive.openLazyBox<T>(name);
    } else {
      await Hive.openBox<T>(name);
    }
  }

  Box<T> get box => Hive.box<T>(name);

  LazyBox<T> get lazyBox => Hive.lazyBox<T>(name);
}
