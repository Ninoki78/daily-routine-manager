import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';

class NotificationHistoryScreen extends StatefulWidget {
  const NotificationHistoryScreen({super.key});
  @override
  State<NotificationHistoryScreen> createState() => _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => _isLoading = true);
    try {
      _notifications = await DatabaseService.instance.getNotificationHistory();
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnim,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange.shade400, Colors.deepOrange.shade300])),
                  child: const Center(child: Text('🔔', style: TextStyle(fontSize: 40))),
                ),
              ),
              title: const Text('Notification History', style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                if (_notifications.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.done_all_rounded),
                    onPressed: () async { await DatabaseService.instance.markAllNotificationsAsRead(); _loadNotifications(); },
                  ),
              ],
            ),
            if (_isLoading)
              const SliverToBoxAdapter(child: SizedBox(height: 300, child: Center(child: CircularProgressIndicator())))
            else if (_notifications.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(60),
                  child: Column(
                    children: [
                      Icon(Icons.notifications_off_rounded, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No notifications yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Your notification history will appear here', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildCard(_notifications[index]),
                  childCount: _notifications.length,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> n) {
    final isRead = n['isRead'] == 1;
    final dt = DateTime.parse(n['sentAt']);
    final type = n['notificationType'] as String;
    final color = type == 'completion' ? Colors.green : Colors.orange;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isRead ? null : color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isRead ? Colors.grey.withOpacity(0.15) : color.withOpacity(0.3)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Icon(type == 'completion' ? Icons.check_circle_rounded : Icons.schedule_rounded, color: color)),
        title: Text(n['routineTitle'], style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 4),
          Text(n['message']),
          const SizedBox(height: 6),
          Text(Helpers.formatDateTime(dt), style: TextStyle(fontSize: 11, color: Colors.grey[400])),
        ]),
        onTap: () { if (!isRead) { DatabaseService.instance.markNotificationAsRead(n['id']); _loadNotifications(); } },
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}