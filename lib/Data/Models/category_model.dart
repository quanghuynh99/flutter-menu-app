import 'package:flutter_todo_web_desktop/Domain/Entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required super.id,
      required super.date,
      required super.title,
      required description,
      required super.createdAt,
      DateTime? updatedAt});

  factory CategoryModel.fromMap(Map<dynamic, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      title: map['title'],
      description: map['description'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  CategoryModel copyWith({
    String? id,
    DateTime? date,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
