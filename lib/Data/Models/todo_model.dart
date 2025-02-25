import 'package:flutter_todo_web_desktop/Domain/Entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createTime,
    required super.priority,
    required super.categoryId,
    super.isPinned,
    super.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createTime: DateTime.parse(json['createTime']),
      priority: Priority.values[json['priority']],
      categoryId: json['categoryId'],
      isPinned: json['isPinned'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createTime': createTime.toIso8601String(),
      'priority': priority.index,
      'categoryId': categoryId,
      'isPinned': isPinned,
      'isCompleted': isCompleted,
    };
  }
}
