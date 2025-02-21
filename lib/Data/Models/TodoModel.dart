import 'package:flutter_todo_web_desktop/Domain/Entities/TodoEntity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required String id,
    required String title,
    required String description,
    required DateTime createTime,
    required Priority priority,
    required String categoryId,
    bool isPinned = false,
    bool isCompleted = false,
  }) : super(
          id: id,
          title: title,
          description: description,
          createTime: createTime,
          priority: priority,
          categoryId: categoryId,
          isPinned: isPinned,
          isCompleted: isCompleted,
        );

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