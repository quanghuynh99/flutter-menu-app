import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Core/Error/todo_state.dart';
import 'package:flutter_todo_web_desktop/Core/UseCase/use_case.dart';
import 'package:flutter_todo_web_desktop/Domain/Entities/todo_entity.dart';

class TodoViewModel extends ChangeNotifier {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  final TogglePin togglePin;

  TodoState _state = TodoState.initial();
  TodoState get state => _state;

  TodoViewModel({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
    required this.togglePin,
  });

  Future<void> loadTodos(String categoryId) async {
    _state = TodoState.loading();
    notifyListeners();

    final result = await getTodos.excute(categoryId);
    _state = result.fold(
      (failure) => TodoState.error(failure.message),
      (todos) => TodoState.loaded(todos),
    );
    notifyListeners();
  }

  Future<void> createTodo(TodoEntity todo) async {
    final result = await addTodo.excute(todo);

    result.fold(
      (failure) {
        _state = TodoState.error(failure.message);
      },
      (_) {
        final updatedTodos = [..._state.todos, todo];
        _state = TodoState.loaded(updatedTodos);
      },
    );
    notifyListeners();
  }

  Future<void> updateTodoItem(TodoEntity todo) async {
    final result = await updateTodo.excute(todo);

    result.fold((failure) {
      _state = TodoState.error(failure.message);
    }, (_) {
      final updateTodo = _state.todos.map((item) {
        return item.id == todo.id ? todo : item;
      }).toList();
      _state = TodoState.loaded(updateTodo);
    });
    notifyListeners();
  }

  Future<void> removeTodo(String id) async {
    final result = await deleteTodo.excute(id);
    result.fold((failure) => TodoState.error(failure.message), (_) {
      final updateTodos =
          _state.todos.where((todo) => todo.id != id).toList(); // onlyUI
      _state = TodoState.loaded(updateTodos);
    });
    notifyListeners();
  }

  Future<void> toggleTodoPin(String id) async {
    final result = await togglePin.excute(id);
    result.fold(
      (failure) {
        _state = TodoState.error(failure.message);
      },
      (_) {
        final updatedTodos = _state.todos.map((todo) {
          if (todo.id == id) {
            return todo.copyWith(isPinned: !todo.isPinned);
          }
          return todo;
        }).toList();
        _state = TodoState.loaded(updatedTodos);
      },
    );
    notifyListeners();
  }
}
