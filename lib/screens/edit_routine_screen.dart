import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../providers/routine_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class EditRoutineScreen extends StatefulWidget {
  final Routine routine;

  const EditRoutineScreen({
    super.key,
    required this.routine,
  });

  @override
  State<EditRoutineScreen> createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _selectedCategory;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late List<String> _selectedDays;
  late bool _notificationEnabled;
  late int _notificationBefore;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.routine.title);
    _descriptionController =
        TextEditingController(text: widget.routine.description);
    _selectedCategory = widget.routine.category;
    _startTime = widget.routine.startTime;
    _endTime = widget.routine.endTime;
    _selectedDays = List.from(widget.routine.daysOfWeek);
    _notificationEnabled = widget.routine.isNotificationEnabled;
    _notificationBefore = widget.routine.notificationBeforeMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Routine'),
        centerTitle: true, // ✅ added
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _updateRoutine,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600, // ✅ slight tweak
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18), // ✅ spacing tweak
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Routine Title'),
              const SizedBox(height: 10), // ✅ spacing tweak
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),

              const SizedBox(height: 22),

              _buildSectionTitle('Description'),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 48),
                    child: Icon(Icons.description),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 22),

              _buildSectionTitle('Category'),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: AppConstants.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppConstants.categoryColors[category],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value!);
                },
              ),

              const SizedBox(height: 22),

              _buildSectionTitle('Time Range'),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10), // ✅ small tweak
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTimePicker(
                          'Start Time',
                          _startTime,
                          (time) => setState(() => _startTime = time),
                        ),
                      ),
                      const Icon(Icons.arrow_forward, color: Colors.grey),
                      Expanded(
                        child: _buildTimePicker(
                          'End Time',
                          _endTime,
                          (time) => setState(() => _endTime = time),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              _buildSectionTitle('Select Days'),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: AppConstants.daysOfWeek.map((day) {
                      return FilterChip(
                        label: Text(day.substring(0, 3)),
                        selected: _selectedDays.contains(day),
                        onSelected: (selected) {
                          setState(() {
                            selected
                                ? _selectedDays.add(day)
                                : _selectedDays.remove(day);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              _buildSectionTitle('Notification Settings'),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Enable Reminder'),
                      value: _notificationEnabled,
                      onChanged: (value) {
                        setState(() => _notificationEnabled = value);
                      },
                      secondary: const Icon(Icons.notifications_active),
                    ),
                    if (_notificationEnabled)
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(72, 0, 16, 16),
                        child: DropdownButtonFormField<int>(
                          value: _notificationBefore,
                          decoration: InputDecoration(
                            labelText: 'Remind me before',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: AppConstants
                              .notificationBeforeOptions
                              .map((minutes) {
                            return DropdownMenuItem(
                              value: minutes,
                              child: Text('$minutes minutes'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _notificationBefore = value!);
                          },
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: _isSaving ? null : _updateRoutine,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Update Routine',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600, // ✅ tweak
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTimePicker(
      String label, TimeOfDay time, Function(TimeOfDay) onTimeChanged) {
    return InkWell(
      onTap: () async {
        final picked =
            await showTimePicker(context: context, initialTime: time);
        if (picked != null) onTimeChanged(picked);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            const SizedBox(height: 4),
            Text(
              Helpers.formatTimeOfDay(time),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateRoutine() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one day'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    final updatedRoutine = widget.routine.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      startTime: _startTime,
      endTime: _endTime,
      daysOfWeek: _selectedDays,
      isNotificationEnabled: _notificationEnabled,
      notificationBeforeMinutes: _notificationBefore,
    );

    final success =
        await context.read<RoutineProvider>().updateRoutine(updatedRoutine);

    if (!mounted) return;

    setState(() => _isSaving = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Routine updated successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}