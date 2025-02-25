enum Priority { high, medium, low }

class TodoEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createTime;
  final Priority priority;
  final String categoryId;
  final bool isPinned;
  final bool isCompleted;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createTime,
    required this.priority,
    required this.categoryId,
    this.isPinned = false,
    this.isCompleted = false,
  });

  TodoEntity copyWith(
      {String? id,
      String? title,
      String? description,
      DateTime? createTime,
      Priority? priority,
      String? categoryId,
      bool? isPinned,
      bool? isCompleted}) {
    return TodoEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createTime: createTime ?? this.createTime,
        priority: priority ?? this.priority,
        categoryId: categoryId ?? this.categoryId,
        isPinned: isPinned ?? this.isPinned,
        isCompleted: isCompleted ?? this.isCompleted);
  }
}
