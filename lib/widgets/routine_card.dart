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
<<<<<<< HEAD
    final categoryColor = AppConstants.categoryColors[routine.category] ?? 
        Colors.blue;
=======
    final categoryColor =
        AppConstants.categoryColors[routine.category] ?? Colors.blue;

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    final today = Helpers.getTodayDayName();
    final isToday = routine.daysOfWeek.contains(today);

    return Card(
<<<<<<< HEAD
      margin: const EdgeInsets.only(bottom: 12),
      elevation: routine.isCompleted ? 1 : 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: routine.isCompleted
              ? Colors.green.withOpacity(0.3)
              : categoryColor.withOpacity(0.3),
=======
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: routine.isCompleted ? 1 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // slightly smoother
        side: BorderSide(
          color: routine.isCompleted
              ? Colors.green.withOpacity(0.25)
              : categoryColor.withOpacity(0.25),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
<<<<<<< HEAD
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
=======
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
            gradient: routine.isCompleted
                ? LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.05),
<<<<<<< HEAD
                      Colors.green.withOpacity(0.1),
=======
                      Colors.green.withOpacity(0.08),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                    ],
                  )
                : null,
          ),
<<<<<<< HEAD
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
=======
          padding: const EdgeInsets.all(14), // slight refinement
          child: Row(
            children: [
              // LEFT BAR
              Container(
                width: 4,
                height: 64,
                decoration: BoxDecoration(
                  color:
                      routine.isCompleted ? Colors.green : categoryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(width: 12),

              // CONTENT
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
<<<<<<< HEAD
=======
                    // TITLE ROW
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            routine.title,
                            style: TextStyle(
<<<<<<< HEAD
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
=======
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
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
<<<<<<< HEAD
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
=======
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.12),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Today',
                              style: TextStyle(
<<<<<<< HEAD
                                fontSize: 12,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
=======
                                fontSize: 11,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                              ),
                            ),
                          ),
                      ],
                    ),
<<<<<<< HEAD
                    const SizedBox(height: 4),
=======

                    const SizedBox(height: 6),

                    // DESCRIPTION
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                    Text(
                      routine.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
<<<<<<< HEAD
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
=======
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // META ROW
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 15, color: Colors.grey[500]),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                        const SizedBox(width: 4),
                        Text(
                          '${Helpers.formatTimeOfDay(routine.startTime)} - ${Helpers.formatTimeOfDay(routine.endTime)}',
                          style: TextStyle(
<<<<<<< HEAD
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
=======
                              fontSize: 12, color: Colors.grey[500]),
                        ),
                        const SizedBox(width: 10),

                        Text(
                          '• ${Helpers.calculateDuration(routine.startTime, routine.endTime)}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[500]),
                        ),

                        const SizedBox(width: 10),

                        // CATEGORY
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                          ),
                          child: Text(
                            routine.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: categoryColor,
<<<<<<< HEAD
                              fontWeight: FontWeight.w500,
=======
                              fontWeight: FontWeight.w600,
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                            ),
                          ),
                        ),
                      ],
                    ),
<<<<<<< HEAD
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
=======

                    const SizedBox(height: 6),

                    // DAYS
                    if (routine.daysOfWeek.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 13, color: Colors.grey[500]),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              routine.daysOfWeek
<<<<<<< HEAD
                                  .map((day) => day.substring(0, 3))
=======
                                  .map((d) => d.substring(0, 3))
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
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

<<<<<<< HEAD
              // Action buttons
              if (showActions) ...[
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Complete button
=======
              // ACTIONS
              if (showActions) ...[
                const SizedBox(width: 6),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                    IconButton(
                      onPressed: onComplete,
                      icon: Icon(
                        routine.isCompleted
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: routine.isCompleted
                            ? Colors.green
                            : Colors.grey[400],
<<<<<<< HEAD
                        size: 28,
                      ),
                      tooltip: routine.isCompleted
                          ? 'Mark as incomplete'
                          : 'Mark as complete',
=======
                        size: 26,
                      ),
                      tooltip: routine.isCompleted
                          ? 'Mark incomplete'
                          : 'Mark complete',
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
                    ),
                    if (onDelete != null)
                      IconButton(
                        onPressed: onDelete,
<<<<<<< HEAD
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 22,
                        ),
                        color: Colors.red[300],
                        tooltip: 'Delete routine',
=======
                        icon: const Icon(Icons.delete_outline, size: 22),
                        color: Colors.redAccent,
                        tooltip: 'Delete',
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
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