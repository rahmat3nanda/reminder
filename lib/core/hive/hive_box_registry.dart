import 'package:hive/hive.dart' show Box, Hive;
import 'package:hive_flutter/hive_flutter.dart' show HiveX;

class HiveBoxRegistry {
  const HiveBoxRegistry();

  static Future<void> register(List<AppHiveBox<dynamic>> boxes) async {
    await Hive.initFlutter();
    await Future.wait(
      boxes
          .map(
            (AppHiveBox<dynamic> e) =>
                e.lazy ? Hive.openLazyBox(e.name) : Hive.openBox(e.name),
          )
          .toList(),
    );
  }
}

class AppHiveBox<E> {
  const AppHiveBox(this.name, {this.lazy = false});

  final String name;
  final bool lazy;

  Box<E> get box => Hive.box<E>(name);
}
