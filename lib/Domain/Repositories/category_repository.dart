import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Core/Error/failure.dart';
import 'package:flutter_todo_web_desktop/Domain/Entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, void>> addCategory(CategoryEntity category);
  Future<Either<Failure, void>> updateCategory(CategoryEntity category);
  Future<Either<Failure, void>> deleteCategory(String id);
  Future<Either<Failure, void>> cacheTodo(List<CategoryRepository> categories);
  // Future<CategoryEntity> getCategoryById(String id);
}

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<Either<Failure, void>> addCategory(CategoryEntity category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> cacheTodo(List<CategoryRepository> categories) {
    // TODO: implement cacheTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateCategory(CategoryEntity category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
