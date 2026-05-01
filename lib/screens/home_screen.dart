import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/routine_provider.dart';
import '../models/routine.dart';
import '../widgets/routine_card.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';
import 'add_routine_screen.dart';
import 'routine_detail_screen.dart';
import 'settings_screen.dart';
import 'notification_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _mainAnimController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<double> _pulseAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;

  int _currentTipIndex = 0;
  final List<Map<String, dynamic>> _tips = [
    {'icon': '💪', 'text': 'Consistency is the key to mastery!'},
    {'icon': '🎯', 'text': 'Small daily improvements lead to stunning results.'},
    {'icon': '🌟', 'text': 'Your future is created by what you do today.'},
    {'icon': '🔥', 'text': 'Stay focused and never give up!'},
    {'icon': '📈', 'text': 'Track your progress, celebrate small wins!'},
  ];

  @override
  void initState() {
    super.initState();

    _mainAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnim =
        CurvedAnimation(parent: _mainAnimController, curve: Curves.easeOut);
    _pulseAnim =
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
    _scaleAnim =
        CurvedAnimation(parent: _slideController, curve: Curves.elasticOut);

    _mainAnimController.forward();
    _slideController.forward();

    _startTipTimer();
    _loadData();
  }

  void _startTipTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _currentTipIndex = (_currentTipIndex + 1) % _tips.length;
        });
        _startTipTimer();
      }
    });
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<RoutineProvider>();
      p.loadRoutines();
      p.fetchMotivationalQuote();
      p.loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildPremiumDrawer(theme),
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + (_pulseAnim.value * 0.1),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          theme.primaryColor.withAlpha(25),
                          theme.primaryColor.withAlpha(12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Main Content
          FadeTransition(
            opacity: _fadeAnim,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildPremiumSliverAppBar(theme),
                SliverToBoxAdapter(child: _buildBody(theme)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildPremiumFAB(theme),
    );
  }

  // =============================================
  // 🎨 PREMIUM SIDEBAR / DRAWER
  // =============================================
  Widget _buildPremiumDrawer(ThemeData theme) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.primaryColor.withOpacity(0.05),
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Drawer Header
              Container(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.5), width: 3),
                          ),
                          child: const Center(
                            child: Text('👤', style: TextStyle(fontSize: 32)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Daily Routine',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                Helpers.getGreeting(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome, color: Colors.amber, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Stay Productive! ✨',
                            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    _buildDrawerItem(
                      icon: Icons.home_rounded,
                      title: 'Home',
                      color: theme.primaryColor,
                      isSelected: true,
                      onTap: () => Navigator.pop(context),
                    ),
                    _buildDrawerItem(
                      icon: Icons.add_circle_outline,
                      title: 'Add New Routine',
                      color: Colors.green,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddRoutineScreen()),
                        ).then((_) => _loadData());
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notification History',
                      color: Colors.orange,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationHistoryScreen()),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.settings_rounded,
                      title: 'Settings',
                      color: Colors.purple,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      },
                    ),
                    const Divider(indent: 20, endIndent: 20),
                    _buildDrawerItem(
                      icon: Icons.info_outline,
                      title: 'About',
                      color: Colors.blueGrey,
                      onTap: () {
                        Navigator.pop(context);
                        showAboutDialog(
                          context: context,
                          applicationName: 'Daily Routine Manager',
                          applicationVersion: '1.0.0',
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon(Icons.star, Colors.amber),
                        const SizedBox(width: 8),
                        _buildSocialIcon(Icons.favorite, Colors.red),
                        const SizedBox(width: 8),
                        _buildSocialIcon(Icons.share, Colors.blue),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Made with ❤️ in Flutter',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required Color color,
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: isSelected ? color.withOpacity(0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? color : null,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  // =============================================
  // 📱 APP BAR WITH HAMBURGER MENU
  // =============================================
  Widget _buildPremiumSliverAppBar(ThemeData theme) {
    final greeting = Helpers.getGreeting();
    final hour = DateTime.now().hour;
    final emoji = hour < 12 ? '🌅' : hour < 17 ? '☀️' : '🌙';

    return SliverAppBar(
      expandedHeight: 230,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: theme.primaryColor,
      leading: GestureDetector(
        onTap: () => _scaffoldKey.currentState?.openDrawer(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor,
                    theme.primaryColor.withOpacity(0.8),
                    theme.primaryColor.withOpacity(0.4),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: -50,
              left: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              right: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(60, 12, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('$greeting ',
                                    style: const TextStyle(color: Colors.white70, fontSize: 16)),
                                Text(emoji, style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Let\'s make today amazing!',
                              style: TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _buildPremiumHeaderIcon(Icons.search_rounded, () {
                              setState(() => _isSearching = true);
                            }),
                            const SizedBox(width: 10),
                            _buildPremiumHeaderIcon(Icons.notifications_outlined, () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (_) => const NotificationHistoryScreen()));
                            }),
                            const SizedBox(width: 10),
                            _buildPremiumHeaderIcon(Icons.settings_rounded, () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const SettingsScreen()));
                            }),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.white.withOpacity(0.1),
                                ],
                              ),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                            ),
                            child: const Center(
                              child: Text('👤', style: TextStyle(fontSize: 28)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your Daily Routines',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Stay consistent, stay productive! ✨',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHeaderIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    return Consumer<RoutineProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return _buildShimmerLoading();
        }

        if (provider.error != null) {
          return _buildErrorState(provider, theme);
        }

        if (provider.routines.isEmpty) {
          return _buildPremiumEmptyState(theme);
        }

        final todayName = Helpers.getTodayDayName();
        final todayRoutines =
            provider.routines.where((r) => r.daysOfWeek.contains(todayName)).toList();
        final completedToday = todayRoutines.where((r) => r.isCompleted).length;
        final totalToday = todayRoutines.length;
        final progress = totalToday > 0 ? completedToday / totalToday : 0.0;

        return Column(
          children: [
            const SizedBox(height: 8),

            // Motivational Quote Card - NOW MORE VISIBLE
            if (provider.motivationalQuote != null)
              _buildVisibleQuoteCard(theme, provider),

            // Progress Ring
            if (totalToday > 0)
              _buildProgressRing(theme, progress, completedToday, totalToday),

            // Stats Cards
            if (provider.statistics != null) _buildPremiumStatsRow(theme, provider),

            // Tip Card
            _buildTipCard(theme),

            // Category Filters
            _buildCategoryFilterChips(theme, provider),

            // Section Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.primaryColor,
                              theme.primaryColor.withOpacity(0.5),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        provider.selectedCategory ?? 'All Routines',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${provider.routines.length} items',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Routine Cards
            ...List.generate(provider.routines.length, (index) {
              final routine = provider.routines[index];
              return SlideTransition(
                position: _slideAnim,
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: RoutineCard(
                      routine: routine,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RoutineDetailScreen(routine: routine)),
                        );
                        _loadData();
                      },
                      onComplete: () {
                        provider.toggleCompletion(routine.id!);
                        HapticFeedback.mediumImpact();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  routine.isCompleted ? Icons.undo : Icons.celebration,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(routine.isCompleted
                                    ? 'Marked incomplete'
                                    : 'Completed! 🎉'),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            duration: const Duration(seconds: 2),
                            backgroundColor:
                                routine.isCompleted ? Colors.grey[700] : Colors.green[600],
                          ),
                        );
                      },
                      onDelete: () => _showPremiumDeleteDialog(routine, theme),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 100),
          ],
        );
      },
    );
  }

  // =============================================
  // 🌟 HIGHLY VISIBLE QUOTE CARD
  // =============================================
  Widget _buildVisibleQuoteCard(ThemeData theme, RoutineProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF667eea),
              const Color(0xFF764ba2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667eea).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Quote icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.format_quote_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 16),
            // Quote text
            Text(
              provider.motivationalQuote!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
            if (provider.quoteAuthor != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '— ${provider.quoteAuthor}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // =============================================
  // 📊 PROGRESS, STATS, TIPS, FILTERS
  // =============================================
  Widget _buildProgressRing(
      ThemeData theme, double progress, int completed, int total) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.primaryColor.withOpacity(0.05), Colors.transparent],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress >= 1 ? Colors.green : theme.primaryColor,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${(progress * 100).round()}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: progress >= 1 ? Colors.green : theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Today\'s Progress',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('$completed of $total routines completed',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                  const SizedBox(height: 8),
                  Text(
                    progress >= 1
                        ? '🎉 All done for today!'
                        : progress >= 0.5
                            ? '🔥 You\'re halfway there!'
                            : '💪 Keep going!',
                    style: TextStyle(
                      color: progress >= 1 ? Colors.green : theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumStatsRow(ThemeData theme, RoutineProvider provider) {
    final stats = provider.statistics!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          _buildPremiumStatCard(
              'Total', '${stats['totalRoutines']}', Icons.list_alt_rounded, Colors.blue, '📋'),
          const SizedBox(width: 10),
          _buildPremiumStatCard(
              'Today', '${stats['todayRoutines']}', Icons.today_rounded, Colors.orange, '📅'),
          const SizedBox(width: 10),
          _buildPremiumStatCard('Done', '${stats['completedToday']}',
              Icons.check_circle_rounded, Colors.green, '✅'),
        ],
      ),
    );
  }

  Widget _buildPremiumStatCard(
      String label, String value, IconData icon, Color color, String emoji) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(value,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(ThemeData theme) {
    final tip = _tips[_currentTipIndex];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Container(
          key: ValueKey<int>(_currentTipIndex),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.shade50, Colors.orange.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Text(tip['icon'], style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(tip['text'],
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown[700],
                        letterSpacing: 0.3)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilterChips(ThemeData theme, RoutineProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildFilterChip('All', null, theme, provider),
            ...AppConstants.categories.map((cat) {
              return _buildFilterChip(cat, cat, theme, provider);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
      String label, String? category, ThemeData theme, RoutineProvider provider) {
    final isSelected = provider.selectedCategory == category;
    final catColor = category != null
        ? (AppConstants.categoryColors[category] ?? theme.primaryColor)
        : theme.primaryColor;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => provider.filterByCategory(isSelected ? null : category),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [catColor, catColor.withOpacity(0.7)])
                : null,
            color: isSelected ? null : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: catColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ]
                : [],
          ),
          child: Text(label,
              style: TextStyle(
                  color: isSelected ? Colors.white : null,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: List.generate(
            4,
            (index) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                )),
      ),
    );
  }

  Widget _buildErrorState(RoutineProvider provider, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Icon(Icons.error_outline_rounded, size: 80, color: Colors.red[200]),
            const SizedBox(height: 20),
            const Text('Oops! Something went wrong',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(provider.error!,
                style: TextStyle(color: Colors.grey[500]), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumEmptyState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.grey.withOpacity(0.15), width: 2),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20)],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [theme.primaryColor.withOpacity(0.1), Colors.transparent]),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.schedule_rounded,
                    size: 80, color: theme.primaryColor.withOpacity(0.5)),
              ),
              const SizedBox(height: 28),
              const Text('No Routines Yet!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const SizedBox(height: 12),
              Text('Start building your productive routine today.\nTap + to get started! ✨',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[500], fontSize: 15, height: 1.5)),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const AddRoutineScreen()))
                    .then((_) => _loadData()),
                icon: const Icon(Icons.add_rounded, size: 22),
                label: const Text('Create Your First Routine',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumFAB(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.5),
            blurRadius: 24,
            offset: const Offset(0, 10),
            spreadRadius: -2,
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AddRoutineScreen()))
            .then((_) => _loadData()),
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
        label: const Text('Add Routine',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
      ),
    );
  }

  void _showPremiumDeleteDialog(Routine routine, ThemeData theme) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
            ),
            const SizedBox(width: 14),
            const Text('Delete Routine',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to delete',
                style: TextStyle(color: Colors.grey[600], fontSize: 15)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: Colors.grey[400], size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('"${routine.title}"',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('This action cannot be undone.',
                style: TextStyle(color: Colors.red[400], fontSize: 13)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep Routine', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.red.shade700]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextButton(
              onPressed: () {
                context.read<RoutineProvider>().deleteRoutine(routine.id!);
                Navigator.pop(ctx);
              },
              child: const Text('Delete',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mainAnimController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }
} 