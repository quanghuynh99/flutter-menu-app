// ignore_for_file: avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Core/UseCase/use_case.dart';
import 'package:flutter_todo_web_desktop/Domain/Entities/category_entity.dart';
import 'package:flutter_todo_web_desktop/Domain/Repositories/category_repository.dart';

import '../Error/failure.dart';

class AddTodo extends UseCase<void, CategoryEntity> {
  final CategoryRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, void>> excute(CategoryEntity category) {
    return repository.addCategory(category);
  }
}
