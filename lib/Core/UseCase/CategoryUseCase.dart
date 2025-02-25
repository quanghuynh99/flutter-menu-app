import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Core/UseCase/UseCase.dart';
import 'package:flutter_todo_web_desktop/Domain/Entities/CategoryEnity.dart';
import 'package:flutter_todo_web_desktop/Domain/Entities/TodoEntity.dart';
import 'package:flutter_todo_web_desktop/Domain/Repositories/CategoryRepository.dart';

import '../Error/Failures.dart';

class AddTodo extends UseCase<void, CategoryEntity> {
  final CategoryRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, void>> excute(CategoryEntity category) {
    return repository.addCategory(category);
  }
}
