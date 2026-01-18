import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidNotificationAction,
        AndroidNotificationDetails,
        AndroidScheduleMode,
        DarwinNotificationDetails,
        DateTimeComponents,
        FlutterLocalNotificationsPlugin,
        Importance,
        NotificationDetails,
        Priority,
        RawResourceAndroidNotificationSound;
import 'package:reminder/features/reminder/domain/entities/reminder.dart'
    show Reminder;
import 'package:reminder/features/reminder/domain/enums/day.dart' show Day;
import 'package:reminder/features/reminder/domain/enums/sound.dart'
    show Sound, SoundResolver;
import 'package:reminder/features/reminder/domain/extensions/reminder_notification_scheduler.dart'
    show ReminderNotificationScheduler;
import 'package:reminder/features/reminder/domain/usecases/reminder_scheduler.dart'
    show ReminderScheduler;
import 'package:timezone/timezone.dart' as tz;

class ReminderLocalScheduler implements ReminderScheduler {
  ReminderLocalScheduler(this.plugin);

  final FlutterLocalNotificationsPlugin plugin;

  @override
  Future<void> schedule(Reminder reminder) async {
    if (!reminder.enabled || reminder.delete) return;

    if (reminder.repeatDays.isEmpty) {
      await _scheduleOneTime(reminder);
    } else {
      await _scheduleRepeating(reminder);
    }
  }

  @override
  Future<void> cancel(Reminder reminder) async {
    if (reminder.repeatDays.isEmpty) {
      await plugin.cancel(reminder.notificationId());
    } else {
      for (final Day day in reminder.repeatDays) {
        await plugin.cancel(reminder.notificationId(day: day));
      }
    }
  }
}

extension _ReminderLocalSchedulerExtension on ReminderLocalScheduler {
  Future<void> _scheduleOneTime(Reminder reminder) async {
    final DateTime date = reminder.nextOneTimeOccurrence();

    await plugin.zonedSchedule(
      reminder.notificationId(),
      reminder.label ?? 'Reminder',
      null,
      tz.TZDateTime.from(date, tz.local),
      _details(reminder),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> _scheduleRepeating(Reminder reminder) async {
    for (final Day day in reminder.repeatDays) {
      final DateTime date = reminder.nextOccurrence(day: day);

      await plugin.zonedSchedule(
        reminder.notificationId(day: day),
        reminder.label ?? 'Reminder',
        null,
        tz.TZDateTime.from(date, tz.local),
        _details(reminder),
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  NotificationDetails _details(Reminder reminder) => NotificationDetails(
    android: AndroidNotificationDetails(
      'reminder_channel',
      'Reminders',
      importance: Importance.max,
      priority: Priority.high,
      sound: reminder.sound == Sound.none
          ? null
          : RawResourceAndroidNotificationSound(reminder.sound.android),
      actions: <AndroidNotificationAction>[
        if (reminder.snoozeMinutes != null)
          const AndroidNotificationAction(
            'SNOOZE',
            'Snooze',
            showsUserInterface: true,
          ),
      ],
    ),
    iOS: DarwinNotificationDetails(
      sound: reminder.sound == Sound.none ? null : reminder.sound.ios,
    ),
  );
}
