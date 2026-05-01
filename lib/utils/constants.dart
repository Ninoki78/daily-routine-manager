import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Daily Routine Manager';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String databaseName = 'routines.db';
  static const int databaseVersion = 1;
  
  // API
  static const String quoteApiBaseUrl = 'https://api.quotable.io';
  static const String weatherApiBaseUrl = 'https://api.openweathermap.org/data/2.5';
  
  // Notification Channels
  static const String notificationChannelId = 'routine_channel';
  static const String notificationChannelName = 'Routine Notifications';
  static const String notificationChannelDesc = 'Notifications for daily routines';
  
  // Categories
  static const List<String> categories = [
    'Work',
    'Exercise',
    'Study',
    'Personal',
    'Health',
    'Other',
  ];
  
  // Days of Week
  static const List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  
  // Notification Times (in minutes)
  static const List<int> notificationBeforeOptions = [5, 10, 15, 30, 60];
  
  // Colors for Categories - Changed from const to static final
  static final Map<String, Color> categoryColors = {
    'Work': const Color(0xFF2196F3),
    'Exercise': const Color(0xFF4CAF50),
    'Study': const Color(0xFFFF9800),
    'Personal': const Color(0xFF9C27B0),
    'Health': const Color(0xFFF44336),
    'Other': const Color(0xFF607D8B),
  };
  
  // Storage Keys
  static const String themeModeKey = 'theme_mode';
  static const String notificationsEnabledKey = 'notifications_enabled';
  static const String firstLaunchKey = 'first_launch';
}