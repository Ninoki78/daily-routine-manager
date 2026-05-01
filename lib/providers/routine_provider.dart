<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';
import '../services/api_service.dart';
import '../utils/helpers.dart';

class RoutineProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;

  // State variables
  List<Routine> _routines = [];
  List<Routine> _filteredRoutines = [];
  Map<String, dynamic>? _statistics;
  String? _motivationalQuote;
  String? _quoteAuthor;
  bool _isLoading = false;
  String? _error;
  String? _selectedCategory;
  bool _showCompletedOnly = false;

  // Getters
  List<Routine> get routines => _filteredRoutines.isEmpty && _selectedCategory == null
      ? _routines
      : _filteredRoutines;
  Map<String, dynamic>? get statistics => _statistics;
  String? get motivationalQuote => _motivationalQuote;
  String? get quoteAuthor => _quoteAuthor;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedCategory => _selectedCategory;

  // Load all routines from database
  Future<void> loadRoutines() async {
    _isLoading = true;
    notifyListeners();

    try {
      _routines = await _databaseService.getAllRoutines();
      _applyFilters();
      _error = null;
      print('📊 Loaded ${_routines.length} routines');
    } catch (e) {
      _error = 'Failed to load routines: $e';
      print('❌ Error loading routines: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load today's routines
  Future<void> loadTodayRoutines() async {
    _isLoading = true;
    notifyListeners();

    try {
      final todayRoutines = await _databaseService.getTodayRoutines();
      _routines = todayRoutines;
      _applyFilters();
      _error = null;
    } catch (e) {
      _error = 'Failed to load today\'s routines: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new routine
  Future<bool> addRoutine(Routine routine) async {
    print('➕ ADDING ROUTINE: ${routine.title}');
    print('   Start: ${routine.startTime.hour}:${routine.startTime.minute.toString().padLeft(2, '0')}');
    print('   End: ${routine.endTime.hour}:${routine.endTime.minute.toString().padLeft(2, '0')}');
    print('   Days: ${routine.daysOfWeek.join(', ')}');
    print('   Notification: ${routine.isNotificationEnabled}');
    print('   Notify before: ${routine.notificationBeforeMinutes} min');
    
    try {
      // Insert routine into database
      final id = await _databaseService.insertRoutine(routine);
      print('   ✅ Inserted with ID: $id');
      
      // Create new routine object with generated ID
      final newRoutine = routine.copyWith(id: id);

      // Schedule notification if enabled
      if (newRoutine.isNotificationEnabled) {
        print('   🔔 Scheduling notification...');
        await _scheduleRoutineNotification(newRoutine);
      } else {
        print('   🔕 Notifications disabled');
      }

      // Refresh routines list
      await loadRoutines();
      print('   ✅ Routine added successfully');
      return true;
    } catch (e) {
      _error = 'Failed to add routine: $e';
      print('   ❌ Error: $e');
      notifyListeners();
      return false;
    }
  }

  // Update existing routine
  Future<bool> updateRoutine(Routine updatedRoutine) async {
    try {
      // Cancel existing notification
      await NotificationService.cancelNotification(updatedRoutine.id!);

      // Update routine in database
      await _databaseService.updateRoutine(updatedRoutine);

      // Reschedule notification if enabled
      if (updatedRoutine.isNotificationEnabled) {
        await _scheduleRoutineNotification(updatedRoutine);
      }

      // Refresh routines list
      await loadRoutines();
      return true;
    } catch (e) {
      _error = 'Failed to update routine: $e';
      notifyListeners();
      return false;
    }
  }

  // Delete routine
  Future<bool> deleteRoutine(int id) async {
    try {
      // Cancel notification
      await NotificationService.cancelNotification(id);
      
      // Delete from database
      await _databaseService.deleteRoutine(id);
      
      // Refresh routines list
      await loadRoutines();
      return true;
    } catch (e) {
      _error = 'Failed to delete routine: $e';
      notifyListeners();
      return false;
    }
  }

  // Toggle routine completion status
  Future<bool> toggleCompletion(int id) async {
    try {
      final routine = _routines.firstWhere((r) => r.id == id);
      final newStatus = !routine.isCompleted;
      
      await _databaseService.toggleRoutineCompletion(id, newStatus);
      
      // If routine is completed, save notification history
      if (newStatus) {
        await _databaseService.insertNotificationHistory(
          routineId: id,
          routineTitle: routine.title,
          message: 'Routine "${routine.title}" completed!',
          notificationType: 'completion',
        );
      }
      
      await loadRoutines();
      return true;
    } catch (e) {
      _error = 'Failed to update routine: $e';
      notifyListeners();
      return false;
    }
  }

  // Filter routines by category
  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  // Toggle completed filter
  void toggleShowCompletedOnly() {
    _showCompletedOnly = !_showCompletedOnly;
    _applyFilters();
    notifyListeners();
  }

  // Search routines
  Future<void> searchRoutines(String query) async {
    if (query.isEmpty) {
      await loadRoutines();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _filteredRoutines = await _databaseService.searchRoutines(query);
      _error = null;
    } catch (e) {
      _error = 'Search failed: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load statistics
  Future<void> loadStatistics() async {
    try {
      _statistics = await _databaseService.getStatistics();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load statistics: $e';
      notifyListeners();
    }
  }

  // Fetch motivational quote from API
  Future<void> fetchMotivationalQuote() async {
    try {
      final quoteData = await ApiService.fetchMotivationalQuote();
      _motivationalQuote = quoteData['content'];
      _quoteAuthor = quoteData['author'];
      notifyListeners();
    } catch (e) {
      // Use a default quote if API fails
      _motivationalQuote = "The secret of getting ahead is getting started.";
      _quoteAuthor = "Mark Twain";
      notifyListeners();
    }
  }

  // ====================================================================
  // PRODUCTION: Schedule notification for a routine
  // This schedules the notification at the CORRECT time (before routine)
  // NO test notifications, NO immediate notifications on save
  // ====================================================================
 Future<void> _scheduleRoutineNotification(Routine routine) async {
    print('───────────────────────────────────────────');
    print('📅 SCHEDULING ROUTINE NOTIFICATION');
    print('   Routine: ${routine.title}');
    print('   Start time: ${routine.startTime.hour}:${routine.startTime.minute.toString().padLeft(2, '0')}');
    print('   Notify before: ${routine.notificationBeforeMinutes} minutes');
    
    final now = DateTime.now();
    print('   Current time: ${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
    
    // Calculate the routine's start time for today
    DateTime routineStartTime = DateTime(
      now.year,
      now.month,
      now.day,
      routine.startTime.hour,
      routine.startTime.minute,
    );
    
    print('   Routine start: ${routineStartTime.hour}:${routineStartTime.minute.toString().padLeft(2, '0')}');
    
    // Subtract the notification buffer
    DateTime notificationTime = routineStartTime.subtract(
      Duration(minutes: routine.notificationBeforeMinutes),
    );
    
    print('   Notification time: ${notificationTime.hour}:${notificationTime.minute.toString().padLeft(2, '0')}');
    
    // If notification time has already passed today, schedule for tomorrow
    if (notificationTime.isBefore(now)) {
      print('   ⚠️ Time already passed for today');
      notificationTime = notificationTime.add(const Duration(days: 1));
      print('   📅 Scheduled for tomorrow: ${notificationTime.day}/${notificationTime.month}');
      print('   ⏰ At: ${notificationTime.hour}:${notificationTime.minute.toString().padLeft(2, '0')}');
    }
    
    final difference = notificationTime.difference(now);
    final hoursUntil = difference.inHours;
    final minutesUntil = difference.inMinutes.remainder(60);
    final secondsUntil = difference.inSeconds.remainder(60);
    
    print('   ⏳ Will notify in: ${hoursUntil}h ${minutesUntil}m ${secondsUntil}s');
    print('   ⏳ Total seconds until notification: ${difference.inSeconds}');
    
    // Schedule the notification using Timer-based approach
    await NotificationService.scheduleNotification(
      id: routine.id!,
      title: '⏰ ${routine.title}',
      body: 'Starts in ${routine.notificationBeforeMinutes} minutes at ${Helpers.formatTimeOfDay(routine.startTime)}',
      scheduledDate: notificationTime,
      payload: 'routine_${routine.id}',
    );
    
    print('   ✅ Notification scheduled');
    print('───────────────────────────────────────────');
  }
  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Apply active filters
  void _applyFilters() {
    _filteredRoutines = List.from(_routines);

    // Apply category filter
    if (_selectedCategory != null) {
      _filteredRoutines = _filteredRoutines
          .where((r) => r.category == _selectedCategory)
          .toList();
    }

    // Apply completed filter
    if (_showCompletedOnly) {
      _filteredRoutines =
          _filteredRoutines.where((r) => r.isCompleted).toList();
    }
  }
}
=======
import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';
import '../services/api_service.dart';
import '../utils/helpers.dart';

class RoutineProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;

  // State variables
  List<Routine> _routines = [];
  List<Routine> _filteredRoutines = [];
  Map<String, dynamic>? _statistics;
  String? _motivationalQuote;
  String? _quoteAuthor;
  bool _isLoading = false;
  String? _error;
  String? _selectedCategory;
  bool _showCompletedOnly = false;

  // Getters
  List<Routine> get routines => _filteredRoutines.isEmpty && _selectedCategory == null
      ? _routines
      : _filteredRoutines;
  Map<String, dynamic>? get statistics => _statistics;
  String? get motivationalQuote => _motivationalQuote;
  String? get quoteAuthor => _quoteAuthor;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedCategory => _selectedCategory;

  // Load all routines from database
  Future<void> loadRoutines() async {
    _isLoading = true;
    notifyListeners();

    try {
      _routines = await _databaseService.getAllRoutines();
      _applyFilters();
      _error = null;
      print('📊 Loaded ${_routines.length} routines');
    } catch (e) {
      _error = 'Failed to load routines: $e';
      print('❌ Error loading routines: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load today's routines
  Future<void> loadTodayRoutines() async {
    _isLoading = true;
    notifyListeners();

    try {
      final todayRoutines = await _databaseService.getTodayRoutines();
      _routines = todayRoutines;
      _applyFilters();
      _error = null;
    } catch (e) {
      _error = 'Failed to load today\'s routines: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add new routine
  Future<bool> addRoutine(Routine routine) async {
    print('➕ ADDING ROUTINE: ${routine.title}');
    print('   Start: ${routine.startTime.hour}:${routine.startTime.minute.toString().padLeft(2, '0')}');
    print('   End: ${routine.endTime.hour}:${routine.endTime.minute.toString().padLeft(2, '0')}');
    print('   Days: ${routine.daysOfWeek.join(', ')}');
    print('   Notification: ${routine.isNotificationEnabled}');
    print('   Notify before: ${routine.notificationBeforeMinutes} min');
    
    try {
      // Insert routine into database
      final id = await _databaseService.insertRoutine(routine);
      print('   ✅ Inserted with ID: $id');
      
      // Create new routine object with generated ID
      final newRoutine = routine.copyWith(id: id);

      // Schedule notification if enabled
      if (newRoutine.isNotificationEnabled) {
        print('   🔔 Scheduling notification...');
        await _scheduleRoutineNotification(newRoutine);
      } else {
        print('   🔕 Notifications disabled');
      }

      // Refresh routines list
      await loadRoutines();
      print('   ✅ Routine added successfully');
      return true;
    } catch (e) {
      _error = 'Failed to add routine: $e';
      print('   ❌ Error: $e');
      notifyListeners();
      return false;
    }
  }

  // Update existing routine
  Future<bool> updateRoutine(Routine updatedRoutine) async {
    try {
      // Cancel existing notification
      await NotificationService.cancelNotification(updatedRoutine.id!);

      // Update routine in database
      await _databaseService.updateRoutine(updatedRoutine);

      // Reschedule notification if enabled
      if (updatedRoutine.isNotificationEnabled) {
        await _scheduleRoutineNotification(updatedRoutine);
      }

      // Refresh routines list
      await loadRoutines();
      return true;
    } catch (e) {
      _error = 'Failed to update routine: $e';
      notifyListeners();
      return false;
    }
  }

  // Delete routine
  Future<bool> deleteRoutine(int id) async {
    try {
      // Cancel notification
      await NotificationService.cancelNotification(id);
      
      // Delete from database
      await _databaseService.deleteRoutine(id);
      
      // Refresh routines list
      await loadRoutines();
      return true;
    } catch (e) {
      _error = 'Failed to delete routine: $e';
      notifyListeners();
      return false;
    }
  }

  // Toggle routine completion status
  Future<bool> toggleCompletion(int id) async {
    try {
      final routine = _routines.firstWhere((r) => r.id == id);
      final newStatus = !routine.isCompleted;
      
      await _databaseService.toggleRoutineCompletion(id, newStatus);
      
      // If routine is completed, save notification history
      if (newStatus) {
        await _databaseService.insertNotificationHistory(
          routineId: id,
          routineTitle: routine.title,
          message: 'Routine "${routine.title}" completed!',
          notificationType: 'completion',
        );
      }
      
      await loadRoutines();
      return true;
    } catch (e) {
      _error = 'Failed to update routine: $e';
      notifyListeners();
      return false;
    }
  }

  // Filter routines by category
  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  // Toggle completed filter
  void toggleShowCompletedOnly() {
    _showCompletedOnly = !_showCompletedOnly;
    _applyFilters();
    notifyListeners();
  }

  // Search routines
  Future<void> searchRoutines(String query) async {
    if (query.isEmpty) {
      await loadRoutines();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _filteredRoutines = await _databaseService.searchRoutines(query);
      _error = null;
    } catch (e) {
      _error = 'Search failed: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load statistics
  Future<void> loadStatistics() async {
    try {
      _statistics = await _databaseService.getStatistics();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load statistics: $e';
      notifyListeners();
    }
  }

  // Fetch motivational quote from API
  Future<void> fetchMotivationalQuote() async {
    try {
      final quoteData = await ApiService.fetchMotivationalQuote();
      _motivationalQuote = quoteData['content'];
      _quoteAuthor = quoteData['author'];
      notifyListeners();
    } catch (e) {
      // Use a default quote if API fails
      _motivationalQuote = "The secret of getting ahead is getting started.";
      _quoteAuthor = "Mark Twain";
      notifyListeners();
    }
  }

  // ====================================================================
  // PRODUCTION: Schedule notification for a routine
  // This schedules the notification at the CORRECT time (before routine)
  // NO test notifications, NO immediate notifications on save
  // ====================================================================
 Future<void> _scheduleRoutineNotification(Routine routine) async {
    print('───────────────────────────────────────────');
    print('📅 SCHEDULING ROUTINE NOTIFICATION');
    print('   Routine: ${routine.title}');
    print('   Start time: ${routine.startTime.hour}:${routine.startTime.minute.toString().padLeft(2, '0')}');
    print('   Notify before: ${routine.notificationBeforeMinutes} minutes');
    
    final now = DateTime.now();
    print('   Current time: ${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
    
    // Calculate the routine's start time for today
    DateTime routineStartTime = DateTime(
      now.year,
      now.month,
      now.day,
      routine.startTime.hour,
      routine.startTime.minute,
    );
    
    print('   Routine start: ${routineStartTime.hour}:${routineStartTime.minute.toString().padLeft(2, '0')}');
    
    // Subtract the notification buffer
    DateTime notificationTime = routineStartTime.subtract(
      Duration(minutes: routine.notificationBeforeMinutes),
    );
    
    print('   Notification time: ${notificationTime.hour}:${notificationTime.minute.toString().padLeft(2, '0')}');
    
    // If notification time has already passed today, schedule for tomorrow
    if (notificationTime.isBefore(now)) {
      print('   ⚠️ Time already passed for today');
      notificationTime = notificationTime.add(const Duration(days: 1));
      print('   📅 Scheduled for tomorrow: ${notificationTime.day}/${notificationTime.month}');
      print('   ⏰ At: ${notificationTime.hour}:${notificationTime.minute.toString().padLeft(2, '0')}');
    }
    
    final difference = notificationTime.difference(now);
    final hoursUntil = difference.inHours;
    final minutesUntil = difference.inMinutes.remainder(60);
    final secondsUntil = difference.inSeconds.remainder(60);
    
    print('   ⏳ Will notify in: ${hoursUntil}h ${minutesUntil}m ${secondsUntil}s');
    print('   ⏳ Total seconds until notification: ${difference.inSeconds}');
    
    // Schedule the notification using Timer-based approach
    await NotificationService.scheduleNotification(
      id: routine.id!,
      title: '⏰ ${routine.title}',
      body: 'Starts in ${routine.notificationBeforeMinutes} minutes at ${Helpers.formatTimeOfDay(routine.startTime)}',
      scheduledDate: notificationTime,
      payload: 'routine_${routine.id}',
    );
    
    print('   ✅ Notification scheduled');
    print('───────────────────────────────────────────');
  }
  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Apply active filters
  void _applyFilters() {
    _filteredRoutines = List.from(_routines);

    // Apply category filter
    if (_selectedCategory != null) {
      _filteredRoutines = _filteredRoutines
          .where((r) => r.category == _selectedCategory)
          .toList();
    }

    // Apply completed filter
    if (_showCompletedOnly) {
      _filteredRoutines =
          _filteredRoutines.where((r) => r.isCompleted).toList();
    }
  }
}
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
