import 'package:dartz/dartz.dart';
import 'package:flutter_todo_web_desktop/Core/Error/cache_exception.dart';
import 'package:flutter_todo_web_desktop/Core/Error/failure.dart';
import 'package:flutter_todo_web_desktop/Data/DataSource/todo_local_data_source.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, void>> addCategory(CategoryModel category);
  Future<Either<Failure, void>> updateCategory(CategoryModel category);
  Future<Either<Failure, void>> deleteCategory(String id);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final TodoLocalDataSource localDataSource;
  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Right(categories);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addCategory(CategoryModel category) async {
    try {
      localDataSource.addCategory(category);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String id) async {
    try {
      await localDataSource.deleteCategory(id);
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategory(CategoryModel category) async {
    try {
      await localDataSource.updateCategory(category);
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
