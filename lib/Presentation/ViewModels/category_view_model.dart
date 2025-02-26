import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Core/Error/todo_state.dart';
import 'package:flutter_todo_web_desktop/Core/UseCase/category_use_case.dart';
import 'package:flutter_todo_web_desktop/Core/UseCase/todo_use_case.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final AddCategory addCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;
  final GetCategories getCategories;

  CategoryState _categoryState = CategoryState.initial();
  CategoryState get categoryState => _categoryState;

  CategoryViewModel(
      {required this.addCategory,
      required this.updateCategory,
      required this.deleteCategory,
      required this.getCategories});

  Future<void> loadCategories() async {
    _categoryState = CategoryState.loading();
    notifyListeners();
    final results = await getCategories.excute(const NoParams());
    _categoryState = results.fold(
      (failure) => CategoryState.error(failure.message),
      (categories) => CategoryState.loaded(categories),
    );
    notifyListeners();
  }

  Future<void> addNewCategory(CategoryModel category) async {
    _categoryState = CategoryState.loading();
    notifyListeners();
    addCategory.excute(category);
    final result = await addCategory.excute(category);
    result.fold((error) {
      _categoryState = CategoryState.error(error.message);
    }, (_) {
      final updateResults = [..._categoryState.categories, category];
      _categoryState = CategoryState.loaded(updateResults);
    });
    notifyListeners();
  }
}
