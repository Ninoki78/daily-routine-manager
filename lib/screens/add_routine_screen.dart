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

class _AddRoutineScreenState extends State<AddRoutineScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Work';
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  final List<String> _selectedDays = [];
  bool _notificationEnabled = true;
  int _notificationBefore = 15;
  bool _isSaving = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

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

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            ),
          ),
        ),
      ),
    );
  }

  // ================= UI =================

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
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
      ),
    );
  }

  Widget _buildCategorySelector(Color color) {
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
    );
  }

  Widget _buildTimeRangeSelector(Color color) {
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
    );
  }

  Widget _buildDaySelector(Color color) {
    return Wrap(
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
        );
      }).toList(),
    );
  }

  Widget _buildNotificationSettings(Color color) {
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
      );
      return;
    }

    setState(() => _isSaving = true);

    final routine = Routine(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      startTime: Helpers.formatTime(_startTime),
      endTime: Helpers.formatTime(_endTime),
      daysOfWeek: _selectedDays,
      notificationEnabled: _notificationEnabled,
      notificationBefore: _notificationBefore,
    );

    await context.read<RoutineProvider>().addRoutine(routine);

    setState(() => _isSaving = false);

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}