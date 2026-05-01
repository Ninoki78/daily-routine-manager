<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
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
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade300])),
                  child: const Center(child: Icon(Icons.settings_rounded, size: 50, color: Colors.white70)),
                ),
              ),
              title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader('🎨 Appearance'),
                    const SizedBox(height: 12),
                    _buildCard(
                      child: Consumer<ThemeProvider>(
                        builder: (context, tp, _) => Column(
                          children: [
                            _themeOption(ThemeMode.light, 'Light Mode', 'Always use light theme', Icons.light_mode_rounded, tp),
                            const Divider(height: 1),
                            _themeOption(ThemeMode.dark, 'Dark Mode', 'Always use dark theme', Icons.dark_mode_rounded, tp),
                            const Divider(height: 1),
                            _themeOption(ThemeMode.system, 'System Default', 'Follow system theme', Icons.settings_brightness_rounded, tp),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _sectionHeader('🔔 Notifications'),
                    const SizedBox(height: 12),
                    _buildCard(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.notifications_active_rounded, color: Colors.blue)),
                            title: const Text('Manage Permissions', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: const Text('Open system notification settings'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () async {
                              final ok = await NotificationService.requestPermission();
                              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(ok ? 'Permission granted ✅' : 'Permission denied'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ));
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.notifications_off_rounded, color: Colors.red)),
                            title: const Text('Cancel All', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: const Text('Remove all scheduled reminders'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () async {
                              await NotificationService.cancelAllNotifications();
                              if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All cancelled'), behavior: SnackBarBehavior.floating));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    _sectionHeader('ℹ️ About'),
                    const SizedBox(height: 12),
                    _buildCard(
                      child: Column(
                        children: [
                          const ListTile(leading: Icon(Icons.info_outline), title: Text('App Version', style: TextStyle(fontWeight: FontWeight.w600)), subtitle: Text('1.0.0')),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.code_rounded),
                            title: const Text('Built with Flutter', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: const Text('Daily Routine Manager'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () => showAboutDialog(context: context, applicationName: 'Daily Routine Manager', applicationVersion: '1.0.0'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(children: [
      Container(width: 4, height: 20, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 10),
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    ]);
  }

  Widget _buildCard({required Widget child}) {
    return Container(decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)]) , child: ClipRRect(borderRadius: BorderRadius.circular(20), child: child));
  }

  Widget _themeOption(ThemeMode mode, String title, String subtitle, IconData icon, ThemeProvider tp) {
    final selected = tp.themeMode == mode;
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: selected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: selected ? Theme.of(context).primaryColor : Colors.grey)),
      title: Text(title, style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(subtitle),
      trailing: selected ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor) : null,
      onTap: () => tp.setThemeMode(mode),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}
=======
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
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
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade300])),
                  child: const Center(child: Icon(Icons.settings_rounded, size: 50, color: Colors.white70)),
                ),
              ),
              title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader('🎨 Appearance'),
                    const SizedBox(height: 12),
                    _buildCard(
                      child: Consumer<ThemeProvider>(
                        builder: (context, tp, _) => Column(
                          children: [
                            _themeOption(ThemeMode.light, 'Light Mode', 'Always use light theme', Icons.light_mode_rounded, tp),
                            const Divider(height: 1),
                            _themeOption(ThemeMode.dark, 'Dark Mode', 'Always use dark theme', Icons.dark_mode_rounded, tp),
                            const Divider(height: 1),
                            _themeOption(ThemeMode.system, 'System Default', 'Follow system theme', Icons.settings_brightness_rounded, tp),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _sectionHeader('🔔 Notifications'),
                    const SizedBox(height: 12),
                    _buildCard(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.notifications_active_rounded, color: Colors.blue)),
                            title: const Text('Manage Permissions', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: const Text('Open system notification settings'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () async {
                              final ok = await NotificationService.requestPermission();
                              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(ok ? 'Permission granted ✅' : 'Permission denied'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ));
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.notifications_off_rounded, color: Colors.red)),
                            title: const Text('Cancel All', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: const Text('Remove all scheduled reminders'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () async {
                              await NotificationService.cancelAllNotifications();
                              if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All cancelled'), behavior: SnackBarBehavior.floating));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    _sectionHeader('ℹ️ About'),
                    const SizedBox(height: 12),
                    _buildCard(
                      child: Column(
                        children: [
                          const ListTile(leading: Icon(Icons.info_outline), title: Text('App Version', style: TextStyle(fontWeight: FontWeight.w600)), subtitle: Text('1.0.0')),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.code_rounded),
                            title: const Text('Built with Flutter', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: const Text('Daily Routine Manager'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () => showAboutDialog(context: context, applicationName: 'Daily Routine Manager', applicationVersion: '1.0.0'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(children: [
      Container(width: 4, height: 20, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 10),
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    ]);
  }

  Widget _buildCard({required Widget child}) {
    return Container(decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)]) , child: ClipRRect(borderRadius: BorderRadius.circular(20), child: child));
  }

  Widget _themeOption(ThemeMode mode, String title, String subtitle, IconData icon, ThemeProvider tp) {
    final selected = tp.themeMode == mode;
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: selected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: selected ? Theme.of(context).primaryColor : Colors.grey)),
      title: Text(title, style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(subtitle),
      trailing: selected ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor) : null,
      onTap: () => tp.setThemeMode(mode),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
