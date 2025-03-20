// ignore_for_file: avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Domain/UseCase/todo_use_case.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Domain/Repositories/category_repository.dart';
import '../../Core/Error/failure.dart';

class AddCategory extends UseCase<void, CategoryModel> {
  final CategoryRepository repository;
  AddCategory(this.repository);

  @override
  Future<Either<Failure, void>> excute(CategoryModel category) {
    return repository.addCategory(category);
  }
}

class UpdateCategory extends UseCase<void, CategoryModel> {
  final CategoryRepository repository;
  UpdateCategory(this.repository);

  @override
  Future<Either<Failure, void>> excute(CategoryModel category) {
    return repository.updateCategory(category);
  }
}

class DeleteCategory extends UseCase<void, String> {
  final CategoryRepository repository;
  DeleteCategory(this.repository);

  @override
  Future<Either<Failure, void>> excute(String params) {
    return repository.deleteCategory(params);
  }
}

class GetCategories extends UseCase<List<CategoryModel>, NoParams> {
  final CategoryRepository repository;
  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<CategoryModel>>> excute(NoParams noParams) {
    return repository.getCategories();
  }
}
