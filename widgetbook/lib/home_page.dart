import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/category_detail.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final mockCategory = CategoryModel(
    id: "id",
    date: "03/03/2025",
    title: "title",
    description: "description",
    createdAt: "createdAt",
    icon: "work",
    completedTasks: 5,
    totalTasks: 20);

@widgetbook.UseCase(name: 'Default', type: CategoryDetail)
Widget buildCoolButtonUseCase(BuildContext context) {
  return CategoryDetail(
    category: mockCategory,
  );
}
