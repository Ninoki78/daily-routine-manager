import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen({super.key});

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

<<<<<<< HEAD
class _AddRoutineScreenState extends State<AddRoutineScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
=======
class _AddRoutineScreenState extends State<AddRoutineScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
  String _selectedCategory = 'Work';
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  final List<String> _selectedDays = [];
  bool _notificationEnabled = true;
  int _notificationBefore = 15;
  bool _isSaving = false;
<<<<<<< HEAD
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _selectedDays.add(Helpers.getTodayDayName());
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
=======

    _selectedDays.add(Helpers.getTodayDayName());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
<<<<<<< HEAD
    final categoryColor = AppConstants.categoryColors[_selectedCategory] ?? Colors.blue;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              categoryColor.withOpacity(0.05),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // Custom Header
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 20,
                    right: 20,
                    bottom: 24,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [categoryColor, categoryColor.withOpacity(0.8)],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: categoryColor.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          '✨ New Routine',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _isSaving ? null : _saveRoutine,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: _isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(
                                    'Save',
                                    style: TextStyle(
                                      color: categoryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader('📝 Routine Details', categoryColor),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _titleController,
                            label: 'Routine Title',
                            hint: 'e.g., Morning Yoga Session',
                            icon: Icons.fitness_center,
                            color: categoryColor,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) return 'Please enter a title';
                              if (value.trim().length < 3) return 'Title must be at least 3 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _descriptionController,
                            label: 'Description',
                            hint: 'Describe what this routine is about...',
                            icon: Icons.description_outlined,
                            color: categoryColor,
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) return 'Please enter a description';
                              return null;
                            },
                          ),
                          const SizedBox(height: 28),
                          
                          _buildSectionHeader('🏷️ Category', categoryColor),
                          const SizedBox(height: 16),
                          _buildCategorySelector(categoryColor),
                          const SizedBox(height: 28),
                          
                          _buildSectionHeader('⏰ Time Range', categoryColor),
                          const SizedBox(height: 16),
                          _buildTimeRangeSelector(categoryColor),
                          const SizedBox(height: 28),
                          
                          _buildSectionHeader('📅 Repeat Days', categoryColor),
                          const SizedBox(height: 16),
                          _buildDaySelector(categoryColor),
                          const SizedBox(height: 28),
                          
                          _buildSectionHeader('🔔 Notifications', categoryColor),
                          const SizedBox(height: 16),
                          _buildNotificationSettings(categoryColor),
                          const SizedBox(height: 32),
                          
                          // Submit Button
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [categoryColor, categoryColor.withOpacity(0.8)]),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: categoryColor.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _isSaving ? null : _saveRoutine,
                                borderRadius: BorderRadius.circular(18),
                                child: Center(
                                  child: _isSaving
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                        )
                                      : const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add_circle_outline, color: Colors.white, size: 24),
                                            SizedBox(width: 10),
                                            Text(
                                              'Create Routine',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
=======
    final categoryColor =
        AppConstants.categoryColors[_selectedCategory] ?? Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Routine'),
        backgroundColor: categoryColor,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveRoutine,
            child: const Text('SAVE', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Details', categoryColor),

                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _titleController,
                    label: 'Title',
                    hint: 'Morning Workout',
                    icon: Icons.title,
                    color: categoryColor,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Title is required';
                      }
                      if (v.length < 3) return 'Too short';
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Optional description',
                    icon: Icons.description,
                    color: categoryColor,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 24),

                  _buildSectionHeader('Category', categoryColor),
                  const SizedBox(height: 12),
                  _buildCategorySelector(categoryColor),

                  const SizedBox(height: 24),

                  _buildSectionHeader('Time', categoryColor),
                  const SizedBox(height: 12),
                  _buildTimeRangeSelector(categoryColor),

                  const SizedBox(height: 24),

                  _buildSectionHeader('Days', categoryColor),
                  const SizedBox(height: 12),
                  _buildDaySelector(categoryColor),

                  const SizedBox(height: 24),

                  _buildSectionHeader('Notifications', categoryColor),
                  const SizedBox(height: 12),
                  _buildNotificationSettings(categoryColor),

                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveRoutine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: categoryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Create Routine'),
                  ),
                ],
              ),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
            ),
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ],
=======
  // ================= UI =================

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color color,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
<<<<<<< HEAD
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: color),
          prefixIcon: Icon(icon, color: color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: color, width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: validator,
        textCapitalization: TextCapitalization.words,
=======
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: color),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
      ),
    );
  }

  Widget _buildCategorySelector(Color color) {
<<<<<<< HEAD
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: AppConstants.categories.map((category) {
          final catColor = AppConstants.categoryColors[category] ?? Colors.blue;
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(colors: [catColor, catColor.withOpacity(0.8)])
                      : null,
                  color: isSelected ? null : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [BoxShadow(color: catColor.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6))]
                      : [],
                ),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(category),
                      color: isSelected ? Colors.white : catColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : null,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
=======
    return Wrap(
      spacing: 10,
      children: AppConstants.categories.map((c) {
        final selected = _selectedCategory == c;
        return ChoiceChip(
          label: Text(c),
          selected: selected,
          selectedColor: color,
          onSelected: (_) => setState(() => _selectedCategory = c),
        );
      }).toList(),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    );
  }

  Widget _buildTimeRangeSelector(Color color) {
<<<<<<< HEAD
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: _buildTimeTile('Start', _startTime, color, (t) {
            setState(() {
              _startTime = t;
              if (!Helpers.isValidTimeRange(_startTime, _endTime)) {
                _endTime = TimeOfDay(hour: (_startTime.hour + 1) % 24, minute: _startTime.minute);
              }
            });
          })),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward_rounded, color: color, size: 20),
          ),
          Expanded(child: _buildTimeTile('End', _endTime, color, (t) => setState(() => _endTime = t))),
        ],
      ),
    );
  }

  Widget _buildTimeTile(String label, TimeOfDay time, Color color, Function(TimeOfDay) onChanged) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(context: context, initialTime: time);
        if (picked != null) onChanged(picked);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Text(
              Helpers.formatTimeOfDay(time),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
=======
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text('Start'),
            subtitle: Text(_startTime.format(context)),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _startTime,
              );
              if (picked != null) {
                setState(() => _startTime = picked);
              }
            },
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('End'),
            subtitle: Text(_endTime.format(context)),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _endTime,
              );
              if (picked != null) {
                setState(() => _endTime = picked);
              }
            },
          ),
        ),
      ],
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    );
  }

  Widget _buildDaySelector(Color color) {
    return Wrap(
<<<<<<< HEAD
      spacing: 10,
      runSpacing: 10,
      children: AppConstants.daysOfWeek.map((day) {
        final isSelected = _selectedDays.contains(day);
        final isToday = day == Helpers.getTodayDayName();
        return GestureDetector(
          onTap: () {
            setState(() {
              isSelected ? _selectedDays.remove(day) : _selectedDays.add(day);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: isSelected ? LinearGradient(colors: [color, color.withOpacity(0.7)]) : null,
              color: isSelected ? null : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isToday && !isSelected ? color.withOpacity(0.5) : Colors.transparent,
                width: isToday ? 2 : 0,
              ),
              boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8)] : [],
            ),
            child: Column(
              children: [
                Text(
                  day.substring(0, 3),
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (isToday) ...[
                  const SizedBox(height: 2),
                  Container(
                    width: 6, height: 6,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
=======
      spacing: 8,
      children: AppConstants.daysOfWeek.map((day) {
        final selected = _selectedDays.contains(day);
        return FilterChip(
          label: Text(day),
          selected: selected,
          onSelected: (_) {
            setState(() {
              selected
                  ? _selectedDays.remove(day)
                  : _selectedDays.add(day);
            });
          },
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
        );
      }).toList(),
    );
  }

  Widget _buildNotificationSettings(Color color) {
<<<<<<< HEAD
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Enable Reminder', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Get notified before routine starts'),
            value: _notificationEnabled,
            onChanged: (v) => setState(() => _notificationEnabled = v),
            activeColor: color,
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _notificationEnabled ? color.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.notifications_active, color: _notificationEnabled ? color : Colors.grey),
            ),
          ),
          if (_notificationEnabled)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.fromLTRB(72, 0, 16, 16),
              child: DropdownButtonFormField<int>(
                value: _notificationBefore,
                decoration: InputDecoration(
                  labelText: 'Remind me before',
                  prefixIcon: Icon(Icons.timer, color: color),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                items: AppConstants.notificationBeforeOptions.map((m) => DropdownMenuItem(
                  value: m,
                  child: Text('$m minutes before'),
                )).toList(),
                onChanged: (v) => setState(() => _notificationBefore = v!),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Work': return Icons.work_outline;
      case 'Exercise': return Icons.fitness_center;
      case 'Study': return Icons.menu_book;
      case 'Personal': return Icons.person_outline;
      case 'Health': return Icons.favorite_border;
      default: return Icons.category;
    }
  }

  void _saveRoutine() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Please select at least one day'), backgroundColor: Colors.red[700], behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      );
      return;
    }
    if (!Helpers.isValidTimeRange(_startTime, _endTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('End time must be after start time'), backgroundColor: Colors.red[700], behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
=======
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Enable Notifications'),
          value: _notificationEnabled,
          onChanged: (v) => setState(() => _notificationEnabled = v),
        ),
        if (_notificationEnabled)
          DropdownButtonFormField<int>(
            value: _notificationBefore,
            items: [5, 10, 15, 30]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text('$e minutes before'),
                    ))
                .toList(),
            onChanged: (v) => setState(() => _notificationBefore = v!),
          ),
      ],
    );
  }

  // ================= SAVE =================

  void _saveRoutine() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one day')),
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
      );
      return;
    }

    setState(() => _isSaving = true);
<<<<<<< HEAD
=======

>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
    final routine = Routine(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
<<<<<<< HEAD
      startTime: _startTime,
      endTime: _endTime,
      daysOfWeek: _selectedDays,
      isNotificationEnabled: _notificationEnabled,
      notificationBeforeMinutes: _notificationBefore,
    );

    final success = await context.read<RoutineProvider>().addRoutine(routine);
    if (!mounted) return;
    setState(() => _isSaving = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(children: [Icon(Icons.celebration, color: Colors.white), SizedBox(width: 8), Text('Routine created! 🎉')]),
          backgroundColor: Colors.green[700],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      Navigator.pop(context, true);
    }
=======
      startTime: Helpers.formatTime(_startTime),
      endTime: Helpers.formatTime(_endTime),
      daysOfWeek: _selectedDays,
      notificationEnabled: _notificationEnabled,
      notificationBefore: _notificationBefore,
    );

    await context.read<RoutineProvider>().addRoutine(routine);

    setState(() => _isSaving = false);

    if (mounted) Navigator.pop(context);
>>>>>>> d828e5ed218e0cc7ab2864fd35371f652e43ff41
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}