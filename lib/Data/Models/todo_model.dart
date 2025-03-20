import 'package:flutter_todo_web_desktop/Domain/Entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createTime,
    required super.updatedAt,
    required super.categoryId,
    super.isPinned,
    super.isCompleted,
  });

  factory TodoModel.fromMap(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createTime: json['createTime'],
      updatedAt: json['updatedAt'],
      categoryId: json['categoryId'],
      isPinned: json['isPinned'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createTime': createTime,
      'updatedAt': updatedAt,
      'categoryId': categoryId,
      'isPinned': isPinned,
      'isCompleted': isCompleted,
    };
  }

  TodoModel copyWith(
      {String? id,
      String? title,
      String? description,
      String? createTime,
      String? updatedAt,
      Priority? priority,
      String? categoryId,
      bool? isPinned,
      bool? isCompleted}) {
    return TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createTime: createTime ?? this.createTime,
        updatedAt: updatedAt ?? this.updatedAt,
        categoryId: categoryId ?? this.categoryId,
        isPinned: isPinned ?? this.isPinned,
        isCompleted: isCompleted ?? this.isCompleted);
  }
}
