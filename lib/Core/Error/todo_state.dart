import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Data/Models/todo_model.dart';

class CategoryState {
  final bool isLoading;
  final String? error;
  final List<CategoryModel> categories;

  const CategoryState(
      {required this.isLoading, this.error, required this.categories});

  factory CategoryState.initial() {
    return const CategoryState(isLoading: false, categories: []);
  }

  factory CategoryState.loading() {
    return const CategoryState(isLoading: true, categories: []);
  }

  factory CategoryState.loaded(List<CategoryModel> categories) {
    return CategoryState(
      isLoading: false,
      categories: categories,
    );
  }

  factory CategoryState.error(String message) {
    return CategoryState(
      isLoading: false,
      error: message,
      categories: [],
    );
  }

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryModel>? categories,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
    );
  }
}

class TodoState {
  final bool isLoading;
  final String? error;
  final List<TodoModel> todos;

  const TodoState({required this.isLoading, this.error, required this.todos});

  factory TodoState.initial() {
    return const TodoState(isLoading: false, todos: []);
  }

  factory TodoState.loading() {
    return const TodoState(isLoading: true, todos: []);
  }

  factory TodoState.loaded(List<TodoModel> todos) {
    return TodoState(
      isLoading: false,
      todos: todos,
    );
  }

  factory TodoState.error(String message) {
    return TodoState(
      isLoading: false,
      error: message,
      todos: [],
    );
  }

  TodoState copyWith({
    bool? isLoading,
    String? error,
    List<TodoModel>? todos,
  }) {
    return TodoState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      todos: todos ?? this.todos,
    );
  }
}
