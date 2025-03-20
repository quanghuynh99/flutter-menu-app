class CategoryEntity {
  final String id;
  final String date;
  final String title;
  final String description;
  final String createdAt;
  final String? updatedAt;
  final String icon;
  final int completedTasks;
  final int totalTasks;

  CategoryEntity(
      {required this.id,
      required this.date,
      required this.title,
      this.description = '',
      required this.createdAt,
      this.updatedAt,
      required this.icon,
      required this.completedTasks,
      required this.totalTasks});
}
