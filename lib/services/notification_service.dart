import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const _lastVisitKey = 'food_last_visit_date';
  static const _channelId = 'food_reminder';
  static const _channelName = 'یادآوری رزرو غذا';
  static const _notifIdBase = 1000;

  final _plugin = FlutterLocalNotificationsPlugin();

  // Fixed Persian calendar ranges during which the university is closed.
  // Update these if the academic calendar changes.
  static const List<_JalaliRange> _holidays = [
    _JalaliRange(month: 1, fromDay: 1, toDay: 13), // Nowruz break
    _JalaliRange(month: 5, fromDay: 1, toDay: 31), // Summer (Mordad)
    _JalaliRange(month: 6, fromDay: 1, toDay: 31), // Summer (Shahrivar)
    _JalaliRange(
      month: 10,
      fromDay: 1,
      toDay: 14,
    ), // Winter break (first half of Dey)
  ];

  bool _isHoliday(DateTime date) {
    final j = Jalali.fromDateTime(date);
    return _holidays.any(
      (r) => j.month == r.month && j.day >= r.fromDay && j.day <= r.toDay,
    );
  }

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Tehran'));

    // v22: initialize() parameters are now named
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
    );

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidImpl?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: 'یادآوری هفتگی رزرو غذا از سامانه صبا یا سماد',
        importance: Importance.high,
      ),
    );

    await androidImpl?.requestNotificationsPermission();
  }

  Future<void> onFoodLinkVisited() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastVisitKey, DateTime.now().toIso8601String());
    await cancelAll();
    await _scheduleWeeklyReminders();
  }

  Future<void> _scheduleWeeklyReminders() async {
    final nextSaturday = _nextSaturday();

    const notifDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'یادآوری هفتگی رزرو غذا',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    for (int i = 0; i < 7; i++) {
      final day = nextSaturday.add(Duration(days: i));
      if (_isHoliday(day)) continue;

      final scheduledTime = tz.TZDateTime(
        tz.local,
        day.year,
        day.month,
        day.day,
        9, // 9:00 AM — change this number to adjust reminder time
        0,
      );

      if (scheduledTime.isAfter(tz.TZDateTime.now(tz.local))) {
        // v22: all parameters in zonedSchedule() are now named
        await _plugin.zonedSchedule(
          id: _notifIdBase + i,
          title: '🍕 رزرو غذا یادت نره !',
          body: 'سامانه سماد رو باز کن و غذای هفته‌ات رو رزرو کن',
          scheduledDate: scheduledTime,
          notificationDetails: notifDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
      }
    }
    // If every day in the week is a holiday (e.g. Nowruz), no notifications
    // are scheduled. The cycle resumes next time the user opens the app.
  }

  Future<void> cancelAll() async {
    for (int i = 0; i < 7; i++) {
      await _plugin.cancel(id: _notifIdBase + i);
    }
  }

  Future<void> restoreIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final lastVisitStr = prefs.getString(_lastVisitKey);
    if (lastVisitStr == null) return;

    final lastVisit = DateTime.parse(lastVisitStr);
    // If the last visit was before this week's Saturday, reminders should
    // already be active — reschedule them in case the device rebooted.
    final thisSaturday = _nextSaturday().subtract(const Duration(days: 7));
    if (lastVisit.isBefore(thisSaturday)) {
      await _scheduleWeeklyReminders();
    }
  }

  DateTime _nextSaturday() {
    final now = DateTime.now();
    // In Dart, weekday 6 = Saturday (1=Mon … 6=Sat, 7=Sun)
    int daysUntil = (6 - now.weekday + 7) % 7;
    if (daysUntil == 0) daysUntil = 7; // already Saturday → go to next week
    return DateTime(now.year, now.month, now.day + daysUntil);
  }
}

class _JalaliRange {
  final int month;
  final int fromDay;
  final int toDay;

  const _JalaliRange({
    required this.month,
    required this.fromDay,
    required this.toDay,
  });
}
