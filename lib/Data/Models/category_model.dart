import 'package:flutter_todo_web_desktop/Domain/Entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required super.id,
      required super.date,
      required super.title,
      required super.description,
      required super.createdAt,
      super.updatedAt,
      required super.icon,
      required super.completedTasks,
      required super.totalTasks});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      date: map['date'],
      title: map['title'],
      description: map['description'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      icon: map['icon'],
      completedTasks: map['completedTasks'],
      totalTasks: map['totalTasks'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'icon': icon,
      'completedTasks': completedTasks,
      'totalTasks': totalTasks
    };
  }

  CategoryModel copyWith({
    String? id,
    String? date,
    String? title,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? icon,
    int? completedTasks,
    int? totalTasks,
  }) {
    return CategoryModel(
        id: id ?? this.id,
        date: date ?? this.date,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        icon: icon ?? this.icon,
        completedTasks: completedTasks ?? this.completedTasks,
        totalTasks: totalTasks ?? this.totalTasks);
  }
}
