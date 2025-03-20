// ignore_for_file: avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Core/Error/failure.dart';
import 'package:flutter_todo_web_desktop/Data/Models/todo_model.dart';
import 'package:flutter_todo_web_desktop/Domain/Repositories/todo_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> excute(Params params);
}

class NoParams {
  const NoParams();
}

class GetTodos extends UseCase<List<TodoModel>, String> {
  final TodoRepository repository;
  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<TodoModel>>> excute(String categoryId) {
    return repository.getTodos(categoryId);
  }
}

class AddTodo extends UseCase<void, TodoModel> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, void>> excute(TodoModel todo) {
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

class UpdateTodo extends UseCase<void, TodoModel> {
  final TodoRepository repository;
  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, void>> excute(TodoModel todo) {
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
