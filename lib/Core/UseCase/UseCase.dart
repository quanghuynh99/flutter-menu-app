import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Core/Error/Failures.dart';
import 'package:flutter_todo_web_desktop/Domain/Entities/TodoEntity.dart';
import 'package:flutter_todo_web_desktop/Domain/Repositories/TodoRepository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> excute(Params params);
}

class GetTodos extends UseCase<List<TodoEntity>, String> {
  final TodoRepository repository;
  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<TodoEntity>>> excute(String categoryId) {
    return repository.getTodos(categoryId);
  }
}

class AddTodo extends UseCase<void, TodoEntity> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, void>> excute(TodoEntity todo) {
    return repository.addTodo(todo);
  }
}

class DeleteTodo extends UseCase<void, String> {
  final TodoRepository repository;
  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> excute(String id) {
    return repository.deleteTodo(id);
  }
}

class UpdateTodo extends UseCase<void, TodoEntity> {
  final TodoRepository repository;
  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, void>> excute(TodoEntity todo) {
    return repository.updateTodo(todo);
  }
}

class TogglePin extends UseCase<void, String> {
  final TodoRepository repository;

  TogglePin(this.repository);

  @override
  Future<Either<Failure, void>> excute(String id) {
    return repository.togglePin(id);
  }
}
