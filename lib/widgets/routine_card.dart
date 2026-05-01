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
    final categoryColor =
        AppConstants.categoryColors[routine.category] ?? Colors.blue;

    final today = Helpers.getTodayDayName();
    final isToday = routine.daysOfWeek.contains(today);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: routine.isCompleted ? 1 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18), // slightly smoother
        side: BorderSide(
          color: routine.isCompleted
              ? Colors.green.withOpacity(0.25)
              : categoryColor.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: routine.isCompleted
                ? LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.05),
                      Colors.green.withOpacity(0.08),
                    ],
                  )
                : null,
          ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE ROW
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            routine.title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
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
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // DESCRIPTION
                    Text(
                      routine.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
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
                        const SizedBox(width: 4),
                        Text(
                          '${Helpers.formatTimeOfDay(routine.startTime)} - ${Helpers.formatTimeOfDay(routine.endTime)}',
                          style: TextStyle(
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
                          ),
                          child: Text(
                            routine.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: categoryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // DAYS
                    if (routine.daysOfWeek.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 13, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              routine.daysOfWeek
                                  .map((d) => d.substring(0, 3))
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

              // ACTIONS
              if (showActions) ...[
                const SizedBox(width: 6),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: onComplete,
                      icon: Icon(
                        routine.isCompleted
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: routine.isCompleted
                            ? Colors.green
                            : Colors.grey[400],
                        size: 26,
                      ),
                      tooltip: routine.isCompleted
                          ? 'Mark incomplete'
                          : 'Mark complete',
                    ),
                    if (onDelete != null)
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline, size: 22),
                        color: Colors.redAccent,
                        tooltip: 'Delete',
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