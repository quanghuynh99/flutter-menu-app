import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/empty_state_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: EmptyStateView)
Widget buildCoolButtonUseCase(BuildContext context) {
  return EmptyStateView();
}
