import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/routine.dart';

class DatabaseService {
  static Database? _database;
  static final DatabaseService instance = DatabaseService._init();

  DatabaseService._init();

  // Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('routines.db');
    return _database!;
  }

  // Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  // Create database tables
  Future<void> _createDB(Database db, int version) async {
    // Create routines table
    await db.execute('''
      CREATE TABLE routines(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL DEFAULT '',
        category TEXT NOT NULL,
        startTime TEXT NOT NULL,
        endTime TEXT NOT NULL,
        daysOfWeek TEXT NOT NULL,
        isNotificationEnabled INTEGER NOT NULL DEFAULT 1,
        notificationBeforeMinutes INTEGER NOT NULL DEFAULT 15,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        isCompleted INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Create notification history table
    await db.execute('''
      CREATE TABLE notification_history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        routineId INTEGER NOT NULL,
        routineTitle TEXT NOT NULL,
        message TEXT NOT NULL,
        notificationType TEXT NOT NULL,
        sentAt TEXT NOT NULL,
        isRead INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (routineId) REFERENCES routines(id) ON DELETE CASCADE
      )
    ''');
  }

  // Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add upgrade logic here if needed in future versions
  }

  // ==================== ROUTINE CRUD OPERATIONS ====================

  // Insert a new routine
  Future<int> insertRoutine(Routine routine) async {
    final db = await database;
    return await db.insert('routines', routine.toMap());
  }

  // Get all routines
  Future<List<Routine>> getAllRoutines() async {
    final db = await database;
    final maps = await db.query(
      'routines',
      orderBy: 'createdAt DESC',
    );
    return maps.map((map) => Routine.fromMap(map)).toList();
  }

  // Get routine by ID
  Future<Routine?> getRoutineById(int id) async {
    final db = await database;
    final maps = await db.query(
      'routines',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Routine.fromMap(maps.first);
    }
    return null;
  }

  // Get routines by category
  Future<List<Routine>> getRoutinesByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'routines',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'createdAt DESC',
    );
    return maps.map((map) => Routine.fromMap(map)).toList();
  }

  // Get routines for specific day
  Future<List<Routine>> getRoutinesForDay(String dayName) async {
    final db = await database;
    final maps = await db.query('routines');
    return maps
        .map((map) => Routine.fromMap(map))
        .where((routine) => routine.daysOfWeek.contains(dayName))
        .toList();
  }

  // Get today's routines
  Future<List<Routine>> getTodayRoutines() async {
    final today = _getTodayName();
    return await getRoutinesForDay(today);
  }

  // Update routine
  Future<int> updateRoutine(Routine routine) async {
    final db = await database;
    final updatedRoutine = routine.copyWith(updatedAt: DateTime.now());
    return await db.update(
      'routines',
      updatedRoutine.toMap(),
      where: 'id = ?',
      whereArgs: [routine.id],
    );
  }

  // Delete routine
  Future<int> deleteRoutine(int id) async {
    final db = await database;
    // Delete associated notification history first
    await db.delete(
      'notification_history',
      where: 'routineId = ?',
      whereArgs: [id],
    );
    // Then delete the routine
    return await db.delete(
      'routines',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Toggle routine completion status
  Future<int> toggleRoutineCompletion(int id, bool isCompleted) async {
    final db = await database;
    return await db.update(
      'routines',
      {
        'isCompleted': isCompleted ? 1 : 0,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get completed routines count for today
  Future<int> getTodayCompletedCount() async {
    final todayRoutines = await getTodayRoutines();
    return todayRoutines.where((r) => r.isCompleted).length;
  }

  // Search routines
  Future<List<Routine>> searchRoutines(String query) async {
    final db = await database;
    final maps = await db.query(
      'routines',
      where: 'title LIKE ? OR description LIKE ? OR category LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'createdAt DESC',
    );
    return maps.map((map) => Routine.fromMap(map)).toList();
  }

  // ==================== NOTIFICATION HISTORY OPERATIONS ====================

  // Insert notification history
  Future<int> insertNotificationHistory({
    required int routineId,
    required String routineTitle,
    required String message,
    required String notificationType,
  }) async {
    final db = await database;
    return await db.insert('notification_history', {
      'routineId': routineId,
      'routineTitle': routineTitle,
      'message': message,
      'notificationType': notificationType,
      'sentAt': DateTime.now().toIso8601String(),
      'isRead': 0,
    });
  }

  // Get all notification history
  Future<List<Map<String, dynamic>>> getNotificationHistory() async {
    final db = await database;
    return await db.query(
      'notification_history',
      orderBy: 'sentAt DESC',
    );
  }

  // Get unread notification count
  Future<int> getUnreadNotificationCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM notification_history WHERE isRead = 0',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Mark notification as read
  Future<int> markNotificationAsRead(int id) async {
    final db = await database;
    return await db.update(
      'notification_history',
      {'isRead': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Mark all notifications as read
  Future<int> markAllNotificationsAsRead() async {
    final db = await database;
    return await db.update(
      'notification_history',
      {'isRead': 1},
      where: 'isRead = 0',
    );
  }

  // Delete old notifications (older than 30 days)
  Future<int> deleteOldNotifications() async {
    final db = await database;
    final thirtyDaysAgo = DateTime.now()
        .subtract(const Duration(days: 30))
        .toIso8601String();
    return await db.delete(
      'notification_history',
      where: 'sentAt < ?',
      whereArgs: [thirtyDaysAgo],
    );
  }

  // ==================== UTILITY METHODS ====================

  // Get database statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final db = await database;

    // Total routines count
    final totalResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM routines',
    );
    final totalRoutines = Sqflite.firstIntValue(totalResult) ?? 0;

    // Active routines (not completed today)
    final today = _getTodayName();
    final allRoutines = await getAllRoutines();
    final todayRoutines =
        allRoutines.where((r) => r.daysOfWeek.contains(today)).toList();
    final completedToday =
        todayRoutines.where((r) => r.isCompleted).length;

    // Category distribution
    final categoryResult = await db.rawQuery(
      'SELECT category, COUNT(*) as count FROM routines GROUP BY category',
    );

    return {
      'totalRoutines': totalRoutines,
      'todayRoutines': todayRoutines.length,
      'completedToday': completedToday,
      'completionRate': todayRoutines.isNotEmpty
          ? (completedToday / todayRoutines.length * 100).round()
          : 0,
      'categoryDistribution': categoryResult,
    };
  }

  // Get today's day name
  String _getTodayName() {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[DateTime.now().weekday - 1];
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}