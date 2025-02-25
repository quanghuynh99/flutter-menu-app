import 'package:flutter_todo_web_desktop/Domain/Entities/todo_entity.dart';

class CategoryEntity {
  final String id;
  final String name;
  final String icon;
  final List<TodoEntity> todos;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.todos,
  });
}
