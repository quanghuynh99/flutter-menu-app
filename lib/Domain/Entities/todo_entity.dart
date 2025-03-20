enum Priority { high, medium, low }

class TodoEntity {
  final String id;
  final String title;
  final String description;
  final String createTime;
  final String updatedAt;
  final String categoryId;
  final bool isPinned;
  final bool isCompleted;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createTime,
    required this.updatedAt,
    required this.categoryId,
    this.isPinned = false,
    this.isCompleted = false,
  });
}
