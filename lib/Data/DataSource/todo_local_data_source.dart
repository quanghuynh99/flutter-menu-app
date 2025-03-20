import 'package:flutter_todo_web_desktop/Core/Error/cache_exception.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Data/Models/todo_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos(String categoryId);
  Future<void> cacheTodos(List<TodoModel> todos);
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<void> togglePin(String id);
  Future<void> toggleComplete(String id);

  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel?> getCategoryById(String id);
  Future<List<CategoryModel>> getCategoriesByDate(String date);
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> deleteCategory(String id);
}

class TodolocaldatasourceImpl implements TodoLocalDataSource {
  final String todosKey = 'todos';
  final String categoriesKey = 'categories';
  final Uuid uuid = Uuid();

  final Box<Map> todoBox;
  final Box<Map> categoryBox;

  TodolocaldatasourceImpl({required this.todoBox, required this.categoryBox});

  @override
  Future<void> addTodo(TodoModel todo) async {
    final todos = _getAllTodos();
    todos.add(todo);
    await _saveTodos(todos);
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    await _saveTodos(todos);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = _getAllTodos();
    todos.removeWhere((todo) => todo.id == id);
    await _saveTodos(todos);
  }

  @override
  Future<List<TodoModel>> getTodos(String categoryId) async {
    final todos = _getAllTodos();
    return todos.where((todo) => todo.categoryId == categoryId).toList();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final todos = _getAllTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);

    if (index != -1) {
      todos[index] = todo.copyWith(
        updatedAt: DateTime.now().toIso8601String(),
      );
      await _saveTodos(todos);
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

  @override
  Future<void> addCategory(CategoryModel category) async {
    try {
      final categories = _getAllCategories();
      categories.add(category);
      await _saveCategories(categories);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    print('LocalDataSource: Starting deleteCategory for id: $id');
    final categories = _getAllCategories();
    print(
        'Raw categories before delete: ${categories.map((c) => c.id).toList()}');

    List<CategoryModel> categoryList = List.from(categories);
    categoryList.removeWhere((item) => item.id == id);
    print('Categories after delete: ${categoryList.map((c) => c.id).toList()}');

    await _saveCategories(categoryList);
    print(
        'LocalDataSource: Category deleted and saved, new length: ${categoryList.length}');
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return _getAllCategories();
  }

  @override
  Future<List<CategoryModel>> getCategoriesByDate(String date) {
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel?> getCategoryById(String id) async {
    final items = _getAllCategories();
    return items.firstWhere((item) => item.id == id);
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    final categories = _getAllCategories();
    final index = categories.indexWhere((item) => item.id == category.id);
    if (index != -1) {
      categories[index] =
          category.copyWith(updatedAt: DateTime.now().toIso8601String());
      await _saveCategories(categories);
    }
  }

  /* 
    Database Helper
  */
  List<TodoModel> _getAllTodos() {
    final todosMap = todoBox.get(todosKey, defaultValue: {}) ?? {};
    return todosMap.values
        .map((todoMap) => TodoModel.fromMap(todoMap))
        .toList();
  }

  Future<void> _saveTodos(List<TodoModel> todos) async {
    final todosMap = {for (var todo in todos) todo.id: todo.toMap()};
    await todoBox.put(todosKey, todosMap);
  }

  List<CategoryModel> _getAllCategories() {
    final categoriesMap = categoryBox.get(categoriesKey, defaultValue: {}) ?? {};
  return categoriesMap.values
      .map((item) => CategoryModel.fromMap(item))
      .toList();
  }

  Future<void> _saveCategories(List<CategoryModel> categories) async {
    final catetoriesMap = {for (var item in categories) item.id: item.toMap()};
    await categoryBox.put(categoriesKey, catetoriesMap);
  }
}
