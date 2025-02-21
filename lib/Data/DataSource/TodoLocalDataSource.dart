import 'package:flutter_todo_web_desktop/Core/Error/Exceptions.dart';
import 'package:flutter_todo_web_desktop/Data/Models/TodoModel.dart';
import 'package:hive/hive.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos(String categoryId);
  Future<void> cacheTodos(List<TodoModel> todos);
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<void> togglePin(String id);
  Future<void> toggleComplete(String id);
}

class TodolocaldatasourceImpl implements TodoLocalDataSource {
  final Box<Map> todoBox;

  TodolocaldatasourceImpl({required this.todoBox});

  @override
  Future<void> addTodo(TodoModel todo) async {
    try {
      await todoBox.put(todo.id, todo.toJson());
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    try {
      await todoBox.clear();
      await todoBox.addAll(todos.map((todo) => todo.toJson()).toList());
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      if (!todoBox.containsKey(id)) {
        throw Exception();
      }
      await todoBox.delete(id);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<TodoModel>> getTodos(String categoryId) async {
    try {
      final todosMap = todoBox.values.toList();
      return todosMap
          .where((todo) => todo['categoryId'] == categoryId)
          .map((todo) => TodoModel.fromJson(Map<String, dynamic>.from(todo)))
          .toList();
    } catch (error) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    try {
      if (!todoBox.containsKey(todo.id)) {
        throw CacheException();
      }
      await todoBox.put(todo.id, todo.toJson());
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> togglePin(String id) async {
    try {
      if (!todoBox.containsKey(id)) {
        throw CacheException();
      }
      final existTodo = Map<String, dynamic>.from(todoBox.get(id)!);
      existTodo['isPinned'] = !existTodo['isPinned'];
      await todoBox.put(id, existTodo);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> toggleComplete(String id) async {
    try {
      if (!todoBox.containsKey(id)) {
        throw CacheException();
      }

      final todoMap = Map<String, dynamic>.from(todoBox.get(id)!);
      todoMap['isCompleted'] = !todoMap['isCompleted'];
      await todoBox.put(id, todoMap);
    } catch (e) {
      throw CacheException();
    }
  }
}
