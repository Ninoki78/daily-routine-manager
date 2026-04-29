import 'package:flutter/material.dart';

class Routine {
  final int? id;
  final String title;
  final String description;
  final String category;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<String> daysOfWeek;
  final bool isNotificationEnabled;
  final int notificationBeforeMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;

  Routine({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
    this.isNotificationEnabled = true,
    this.notificationBeforeMinutes = 15,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isCompleted = false,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Copy with method for easy updates
  Routine copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<String>? daysOfWeek,
    bool? isNotificationEnabled,
    int? notificationBeforeMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCompleted,
  }) {
    return Routine(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
      notificationBeforeMinutes:
          notificationBeforeMinutes ?? this.notificationBeforeMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Convert to Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'daysOfWeek': daysOfWeek.join(','),
      'isNotificationEnabled': isNotificationEnabled ? 1 : 0,
      'notificationBeforeMinutes': notificationBeforeMinutes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Create from SQLite Map
  factory Routine.fromMap(Map<String, dynamic> map) {
    List<String> startParts = map['startTime'].split(':');
    List<String> endParts = map['endTime'].split(':');

    return Routine(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      category: map['category'],
      startTime: TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      ),
      daysOfWeek: (map['daysOfWeek'] as String).split(','),
      isNotificationEnabled: map['isNotificationEnabled'] == 1,
      notificationBeforeMinutes: map['notificationBeforeMinutes'] ?? 15,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
      isCompleted: map['isCompleted'] == 1,
    );
  }

  // Convert to JSON for API if needed
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'startTime': {
        'hour': startTime.hour,
        'minute': startTime.minute,
      },
      'endTime': {
        'hour': endTime.hour,
        'minute': endTime.minute,
      },
      'daysOfWeek': daysOfWeek,
      'isNotificationEnabled': isNotificationEnabled,
      'notificationBeforeMinutes': notificationBeforeMinutes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  @override
  String toString() {
    return 'Routine(id: $id, title: $title, category: $category)';
  }
}