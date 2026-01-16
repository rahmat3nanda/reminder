import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/hive_flutter.dart' show HiveX;

class HiveBoxRegistry {
  const HiveBoxRegistry();

  static Future<void> register(List<AppHiveBox> boxes) async {
    await Hive.initFlutter();
    await Future.wait(
      boxes
          .map(
            (AppHiveBox e) =>
                e.lazy ? Hive.openLazyBox(e.box) : Hive.openBox(e.box),
          )
          .toList(),
    );
  }
}

class AppHiveBox {
  const AppHiveBox(this.box, {this.lazy = false});

  final String box;
  final bool lazy;
}
