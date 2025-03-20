import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/app_icons.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:uuid/uuid.dart';

class AddCategoryDialog extends StatefulWidget {
  final Function(CategoryModel) addOnCategory;

  const AddCategoryDialog({super.key, required this.addOnCategory});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedIcon = 'category';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Thêm danh mục mới'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên danh mục',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên danh mục';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Hoặc lựa chọn các danh mục có sẵn dưới đây: ',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: AppIcons.topicIcons.map((item) {
                  final isSelected = _selectedIcon == item['name'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIcon = item['name'];
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(
                        item['icon'],
                        color: isSelected
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newCategory = CategoryModel(
                id: Uuid().v4(),
                title: _nameController.text,
                description: "_selectedIcon",
                date: DateTime.now().toIso8601String(),
                createdAt: DateTime.now().toIso8601String(),
                icon: _selectedIcon,
                completedTasks: 0,
                totalTasks: 0,
              );
              widget.addOnCategory(newCategory);
              Navigator.pop(context);
            }
          },
          child: const Text('Thêm mới'),
        ),
      ],
    );
  }
}
