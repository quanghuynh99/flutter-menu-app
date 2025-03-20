import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/constants/sizes.dart';
import 'package:flutter_todo_web_desktop/Data/Models/todo_model.dart';

class AddTaskDialog extends StatefulWidget {
  final String categoryId;
  final Function(TodoModel) onTaskAdded;
  final TodoModel? todo;

  const AddTaskDialog({
    super.key,
    this.todo,
    required this.categoryId,
    required this.onTaskAdded,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isPinned = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.add_task, color: theme.colorScheme.primary),
          SizedBox(width: TSizes.itemSpacing.left),
          Text(widget.todo == null ? 'Add New Task' : 'Edit Task',
              style: theme.textTheme.titleLarge),
        ],
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: widget.todo == null
                      ? 'Enter task title'
                      : widget.todo!.title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: widget.todo == null
                      ? 'Enter task description'
                      : widget.todo!.description,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Pin this task'),
                subtitle:
                    const Text('Pinned tasks appear at the top of your list'),
                secondary: Icon(
                  Icons.push_pin,
                  color: _isPinned ? theme.colorScheme.primary : null,
                ),
                value: _isPinned,
                onChanged: (value) {
                  setState(() {
                    _isPinned = value;
                  });
                },
                activeColor: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          label: Padding(
            padding: TSizes.itemSpacing,
            child: Text(widget.todo == null ? 'Add Task' : 'Save'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final now = DateTime.now().toString();
              final newTask = TodoModel(
                id: widget.todo == null ? DateTime.now().millisecondsSinceEpoch.toString() : widget.todo!.id,
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                createTime: now,
                updatedAt: now,
                categoryId: widget.categoryId,
                isPinned: _isPinned,
                isCompleted: false,
              );

              widget.onTaskAdded(newTask);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
