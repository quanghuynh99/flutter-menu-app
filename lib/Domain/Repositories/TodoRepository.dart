import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Core/Error/Exceptions.dart';
import 'package:flutter_todo_web_desktop/Data/DataSource/TodoLocalDataSource.dart';
import 'package:flutter_todo_web_desktop/Data/Models/TodoModel.dart';
import 'package:flutter_todo_web_desktop/Domain/Entities/TodoEntity.dart';
import 'package:flutter_todo_web_desktop/Core/Error/Failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getTodos(String categoryId);
  Future<Either<Failure, void>> addTodo(TodoEntity todo);
  Future<Either<Failure, void>> updateTodo(TodoEntity todo);
  Future<Either<Failure, void>> deleteTodo(String id);
  Future<Either<Failure, void>> togglePin(String id);
  Future<Either<Failure, void>> toggleComplete(String id);
  Future<Either<Failure, void>> cacheTodo(List<TodoEntity> todos);
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> addTodo(TodoEntity todo) async {
    try {
      localDataSource.addTodo(todo as TodoModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodos(String categoryId) async {
    try {
      final todos = await localDataSource.getTodos(categoryId);
      return Right(todos);
    } on CacheException {
      return Left(CacheFailure('Failed to load todos'));
    }
  }

  @override
  Future<Either<Failure, void>> togglePin(String id) async {
    try {
      await localDataSource.togglePin(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(TodoEntity todo) async {
    try {
      await localDataSource.updateTodo(todo as TodoModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> toggleComplete(String id) async {
    try {
      await localDataSource.toggleComplete(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> cacheTodo(List<TodoEntity> todos) async {
    try {
      final todoModels = todos.map((todo) => todo as TodoModel).toList();
      await localDataSource.cacheTodos(todoModels);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
