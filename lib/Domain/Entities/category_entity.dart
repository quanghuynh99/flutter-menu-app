class CategoryEntity {
  final String id;
  final DateTime date;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CategoryEntity({
    required this.id,
    required this.date,
    required this.title,
    this.description = '',
    required this.createdAt,
    this.updatedAt,
  });
}
