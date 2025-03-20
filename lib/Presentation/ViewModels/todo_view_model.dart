// todo_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Data/Models/todo_model.dart';
import 'package:flutter_todo_web_desktop/Domain/UseCase/todo_use_case.dart';

class TodoViewModel extends ChangeNotifier {
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final GetTodos getTodos;

  TodoViewModel({
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
    required this.getTodos,
  });

  List<TodoModel> _todos = [];
  bool _isLoading = false;
  String? _error;

  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTodos({String? categoryId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getTodos.excute(categoryId!);
      result.fold((error) {
        print("Error when load results");
      }, (items) {
        _todos = items;
      });
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTodo(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    try {
      await addTodo.excute(todo);
      await loadTodos(categoryId: todo.categoryId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTodoItem(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    try {
      await updateTodo.excute(todo);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
      await loadTodos(categoryId: todo.categoryId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTodoItem(String todoId) async {
    try {
      await deleteTodo.excute(todoId);
      _todos.removeWhere((todo) => todo.id == todoId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
