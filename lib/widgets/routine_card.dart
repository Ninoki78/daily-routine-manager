import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;
  final VoidCallback? onDelete;
  final bool showActions;

  const RoutineCard({
    super.key,
    required this.routine,
    this.onTap,
    this.onComplete,
    this.onDelete,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = AppConstants.categoryColors[routine.category] ?? 
        Colors.blue;
    final today = Helpers.getTodayDayName();
    final isToday = routine.daysOfWeek.contains(today);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: routine.isCompleted ? 1 : 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: routine.isCompleted
              ? Colors.green.withOpacity(0.3)
              : categoryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: routine.isCompleted
                ? LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.05),
                      Colors.green.withOpacity(0.1),
                    ],
                  )
                : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Category indicator
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: routine.isCompleted ? Colors.green : categoryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),

              // Routine content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            routine.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: routine.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: routine.isCompleted
                                  ? Colors.grey
                                  : null,
                            ),
                          ),
                        ),
                        if (isToday && !routine.isCompleted)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      routine.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Time indicator
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${Helpers.formatTimeOfDay(routine.startTime)} - ${Helpers.formatTimeOfDay(routine.endTime)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Duration
                        Text(
                          '• ${Helpers.calculateDuration(routine.startTime, routine.endTime)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Category badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            routine.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: categoryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Days indicator
                    if (routine.daysOfWeek.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              routine.daysOfWeek
                                  .map((day) => day.substring(0, 3))
                                  .join(', '),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Action buttons
              if (showActions) ...[
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Complete button
                    IconButton(
                      onPressed: onComplete,
                      icon: Icon(
                        routine.isCompleted
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: routine.isCompleted
                            ? Colors.green
                            : Colors.grey[400],
                        size: 28,
                      ),
                      tooltip: routine.isCompleted
                          ? 'Mark as incomplete'
                          : 'Mark as complete',
                    ),
                    if (onDelete != null)
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 22,
                        ),
                        color: Colors.red[300],
                        tooltip: 'Delete routine',
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}