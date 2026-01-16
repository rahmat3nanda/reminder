import 'package:hive/hive.dart' show Box, Hive;
import 'package:hive_flutter/hive_flutter.dart' show HiveX;

class HiveBoxRegistry {
  const HiveBoxRegistry();

  static Future<void> register(List<AppHiveBox> boxes) async {
    await Hive.initFlutter();

    await Future.wait(
      boxes.map((AppHiveBox e) {
        if (Hive.isBoxOpen(e.name)) {
          return Future<void>.value();
        }

        return e.lazy ? Hive.openLazyBox(e.name) : Hive.openBox(e.name);
      }),
    );
  }
}

class AppHiveBox {
  const AppHiveBox(this.name, {this.lazy = false});

  final String name;
  final bool lazy;

  Box<dynamic> get box => Hive.box(name);
}
