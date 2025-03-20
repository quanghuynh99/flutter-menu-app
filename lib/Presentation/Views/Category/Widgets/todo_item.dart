import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Data/Models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(bool) onToggleCompleted;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggleCompleted,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = todo.isCompleted
        ? TextStyle(
            decoration: TextDecoration.lineThrough,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          )
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            if (value != null) {
              onToggleCompleted(value);
            }
          },
          activeColor: theme.colorScheme.primary,
        ),
        title: Text(
          todo.title,
          style: textStyle,
        ),
        subtitle: todo.description.isNotEmpty
            ? Text(
                todo.description,
                style: textStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (todo.isPinned)
              Icon(
                Icons.push_pin,
                color: theme.colorScheme.primary,
              ),
            IconButton(
              icon: Icon(Icons.edit, size: 20),
              color: theme.colorScheme.primary,
              onPressed: onEdit,
              tooltip: 'Edit Task',
            ),
            IconButton(
              icon: Icon(Icons.delete, size: 20),
              color: theme.colorScheme.error,
              onPressed: onDelete,
              tooltip: 'Delete Task',
            ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      ),
    );
  }
}
