import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidFlutterLocalNotificationsPlugin,
        AndroidInitializationSettings,
        DarwinInitializationSettings,
        FlutterLocalNotificationsPlugin,
        InitializationSettings;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService._internal();

  static final LocalNotificationService instance =
      LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings android = AndroidInitializationSettings(
      '@drawable/alarm',
    );

    const DarwinInitializationSettings ios = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await instance.plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    await instance.plugin.initialize(settings);
  }
}
