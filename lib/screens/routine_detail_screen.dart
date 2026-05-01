import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'edit_routine_screen.dart';

class RoutineDetailScreen extends StatefulWidget {
  final Routine routine;
  const RoutineDetailScreen({super.key, required this.routine});

  @override
  State<RoutineDetailScreen> createState() => _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = AppConstants.categoryColors[widget.routine.category] ?? Colors.blue;
    
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnim,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 240,
              pinned: true,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                ),
              ),
              actions: [
                _buildActionBtn(Icons.edit_rounded, () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditRoutineScreen(routine: widget.routine))).then((v) { if (v == true) Navigator.pop(context, true); })),
                _buildActionBtn(Icons.delete_outline, () => _showDeleteDialog(context)),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [categoryColor, categoryColor.withOpacity(0.6)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                          child: Icon(_getCategoryIcon(widget.routine.category), size: 50, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                          child: Text(widget.routine.category, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.routine.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        ),
                        GestureDetector(
                          onTap: () => context.read<RoutineProvider>().toggleCompletion(widget.routine.id!),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: widget.routine.isCompleted ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              widget.routine.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                              color: widget.routine.isCompleted ? Colors.green : Colors.grey,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(widget.routine.description, style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.6)),
                    const SizedBox(height: 28),
                    _buildInfoTile(Icons.access_time_filled, 'Time', '${Helpers.formatTimeOfDay(widget.routine.startTime)} → ${Helpers.formatTimeOfDay(widget.routine.endTime)}', categoryColor, 'Duration: ${Helpers.calculateDuration(widget.routine.startTime, widget.routine.endTime)}'),
                    const SizedBox(height: 14),
                    _buildInfoTile(Icons.calendar_month_rounded, 'Repeat Days', widget.routine.daysOfWeek.join(', '), categoryColor, '${widget.routine.daysOfWeek.length} day(s)/week'),
                    const SizedBox(height: 14),
                    _buildInfoTile(Icons.notifications_active_rounded, 'Reminder', widget.routine.isNotificationEnabled ? '${widget.routine.notificationBeforeMinutes} min before' : 'Disabled', widget.routine.isNotificationEnabled ? Colors.orange : Colors.grey),
                    const SizedBox(height: 32),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            Text('Created ${Helpers.formatDate(widget.routine.createdAt)}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                            if (widget.routine.updatedAt != widget.routine.createdAt)
                              Text('Updated ${Helpers.formatDate(widget.routine.updatedAt)}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value, Color color, [String? subtitle]) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                if (subtitle != null) Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Work': return Icons.work_rounded;
      case 'Exercise': return Icons.fitness_center_rounded;
      case 'Study': return Icons.menu_book_rounded;
      case 'Personal': return Icons.person_rounded;
      case 'Health': return Icons.favorite_rounded;
      default: return Icons.category_rounded;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Delete Routine?'),
        content: Text('This will permanently remove "${widget.routine.title}".'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Keep')),
          TextButton(onPressed: () { context.read<RoutineProvider>().deleteRoutine(widget.routine.id!); Navigator.pop(ctx); Navigator.pop(context, true); }, style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text('Delete')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}