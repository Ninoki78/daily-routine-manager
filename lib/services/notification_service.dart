import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../utils/constants.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
<<<<<<< HEAD
  
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
  // Store active timers so they can be cancelled
  static final Map<int, Timer> _activeTimers = {};

  // Initialize notification service
  static Future<void> initialize() async {
    tz.initializeTimeZones();
<<<<<<< HEAD
    
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    try {
      tz.setLocalLocation(tz.getLocation('Africa/Addis_Ababa'));
    } catch (e) {
      print('Timezone error: $e');
      tz.setLocalLocation(tz.UTC);
    }
<<<<<<< HEAD
    
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTap,
    );
<<<<<<< HEAD
    
    await createNotificationChannel();
    
=======

    await createNotificationChannel();

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    print('✅ NotificationService initialized');
  }

  static void _onNotificationTap(NotificationResponse response) {
    print('🔔 Notification tapped: ${response.payload}');
  }

  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTap(NotificationResponse response) {
    print('🔔 Background notification tapped: ${response.payload}');
  }

  // Request permissions
  static Future<bool> requestPermission() async {
    print('📋 Requesting notification permissions...');
<<<<<<< HEAD
    
    var status = await Permission.notification.status;
    print('Current permission status: $status');
    
=======

    var status = await Permission.notification.status;
    print('Current permission status: $status');

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    if (status.isDenied) {
      status = await Permission.notification.request();
      print('After request: $status');
    }
<<<<<<< HEAD
    
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
    
=======

    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    return status.isGranted;
  }

  // Check if permission is granted
  static Future<bool> hasPermission() async {
    return await Permission.notification.isGranted;
  }

  // Show a notification immediately
  static Future<void> _showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      AppConstants.notificationChannelId,
      AppConstants.notificationChannelName,
      channelDescription: AppConstants.notificationChannelDesc,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
<<<<<<< HEAD
    
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    print('📱 Notification SHOWN: $title');
  }

  // ================================================================
  // THIS IS THE KEY FIX: Use Timer for scheduling
  // Timers work even when zonedSchedule fails on Samsung
  // ================================================================
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    print('═══════════════════════════════════════');
    print('📅 SCHEDULING NOTIFICATION');
    print('   ID: $id');
    print('   Title: $title');
    print('   Scheduled for: $scheduledDate');
    print('   Current time: ${DateTime.now()}');
<<<<<<< HEAD
    
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    // Check if time is in the past
    if (scheduledDate.isBefore(DateTime.now())) {
      print('   ⚠️ Time is in the past! Not scheduling.');
      print('═══════════════════════════════════════');
      return;
    }
<<<<<<< HEAD
    
    final difference = scheduledDate.difference(DateTime.now());
    print('   ⏰ Will fire in: ${difference.inHours}h ${difference.inMinutes.remainder(60)}m ${difference.inSeconds.remainder(60)}s');
    
    // Cancel any existing timer for this ID
    _activeTimers[id]?.cancel();
    
    // METHOD 1: Try zonedSchedule first (works on some devices)
    try {
      final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);
      
=======

    final difference = scheduledDate.difference(DateTime.now());
    print('   ⏰ Will fire in: ${difference.inHours}h ${difference.inMinutes.remainder(60)}m ${difference.inSeconds.remainder(60)}s');

    // Cancel any existing timer for this ID
    _activeTimers[id]?.cancel();

    // METHOD 1: Try zonedSchedule first (works on some devices)
    try {
      final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
      const androidDetails = AndroidNotificationDetails(
        AppConstants.notificationChannelId,
        AppConstants.notificationChannelName,
        channelDescription: AppConstants.notificationChannelDesc,
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
        playSound: true,
        enableVibration: true,
        category: AndroidNotificationCategory.alarm,
        fullScreenIntent: true,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      );

      await _notificationsPlugin.zonedSchedule(
        id + 100000,  // Different ID to avoid conflict with Timer
        title,
        body,
        tzScheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
<<<<<<< HEAD
      
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
      print('   ✅ zonedSchedule set as backup');
    } catch (e) {
      print('   ⚠️ zonedSchedule failed: $e');
    }
<<<<<<< HEAD
    
    // METHOD 2: Use Timer (MORE RELIABLE on Samsung)
    // This will fire even if zonedSchedule doesn't
    print('   ⏲️ Setting Timer for ${difference.inSeconds} seconds from now');
    
=======

    // METHOD 2: Use Timer (MORE RELIABLE on Samsung)
    // This will fire even if zonedSchedule doesn't
    print('   ⏲️ Setting Timer for ${difference.inSeconds} seconds from now');

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    final timer = Timer(difference, () async {
      print('⏰ TIMER FIRED! Showing notification for: $title');
      await _showNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      );
      _activeTimers.remove(id);
    });
<<<<<<< HEAD
    
    _activeTimers[id] = timer;
    
=======

    _activeTimers[id] = timer;

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    print('   ✅ Timer set successfully');
    print('   📊 Active timers: ${_activeTimers.length}');
    print('═══════════════════════════════════');
  }

  // Cancel a specific notification
  static Future<void> cancelNotification(int id) async {
    // Cancel Timer
    _activeTimers[id]?.cancel();
    _activeTimers.remove(id);
<<<<<<< HEAD
    
    // Cancel zonedSchedule
    await _notificationsPlugin.cancel(id + 100000);
    await _notificationsPlugin.cancel(id);
    
=======

    // Cancel zonedSchedule
    await _notificationsPlugin.cancel(id + 100000);
    await _notificationsPlugin.cancel(id);

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    print('🗑️ Cancelled notification: $id');
  }

  // Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    // Cancel all timers
    for (var timer in _activeTimers.values) {
      timer.cancel();
    }
    _activeTimers.clear();
<<<<<<< HEAD
    
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    await _notificationsPlugin.cancelAll();
    print('🗑️ All notifications cancelled');
  }

  // Get list of pending notifications
  static Future<List<PendingNotificationRequest>>
      getPendingNotifications() async {
    return await _notificationsPlugin.pendingNotificationRequests();
  }

  // Check if a notification with specific ID exists
  static bool hasPendingNotification(int id) {
    return _activeTimers.containsKey(id);
  }

  // Create a notification channel (for Android)
  static Future<void> createNotificationChannel() async {
    print('📡 Creating notification channel...');
<<<<<<< HEAD
    
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    const androidChannel = AndroidNotificationChannel(
      AppConstants.notificationChannelId,
      AppConstants.notificationChannelName,
      description: AppConstants.notificationChannelDesc,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(androidChannel);
      print('✅ Notification channel created');
    } else {
      print('⚠️ Could not create channel - no Android plugin');
    }
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
