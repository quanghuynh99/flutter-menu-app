import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/todo_state.dart';
import 'package:flutter_todo_web_desktop/Domain/UseCase/category_use_case.dart';
import 'package:flutter_todo_web_desktop/Domain/UseCase/todo_use_case.dart';
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
      required this.getCategories}) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    _categoryState =
        CategoryState.loading(currentCategories: categoryState.categories);
    notifyListeners();
    final results = await getCategories.excute(const NoParams());
    results.fold(
      (failure) => _categoryState =
          CategoryState.error(failure.message, categoryState.categories),
      (categories) {
        print("categories.lengtH ---- ${categories.length}");
        _categoryState = CategoryState.loaded(categories);
      },
    );
    notifyListeners();
  }

  Future<void> addNewCategory(CategoryModel category) async {
    _categoryState =
        CategoryState.loading(currentCategories: categoryState.categories);
    notifyListeners();
    addCategory.excute(category);
    final result = await addCategory.excute(category);

    result.fold((error) {
      _categoryState =
          CategoryState.error(error.message, categoryState.categories);
    }, (_) {
      final updateResults = [..._categoryState.categories, category];
      _categoryState = CategoryState.loaded(updateResults);
    });
    notifyListeners();
  }

  Future<void> deleteCategoryById(String categoryId) async {
    print('Starting deleteCategoryById for $categoryId');
    try {
      _categoryState =
          CategoryState.loading(currentCategories: categoryState.categories);
      notifyListeners();

      final result = await deleteCategory.excute(categoryId);
      result.fold(
        (error) {
          _categoryState =
              CategoryState.error(error.message, categoryState.categories);
          notifyListeners();
        },
        (_) async {
          await loadCategories();
          print(
              'Categories after delete in ViewModel: ${_categoryState.categories.map((c) => c.id).toList()}');
        },
      );
    } catch (e) {
      _categoryState =
          CategoryState.error(e.toString(), categoryState.categories);
      notifyListeners();
    }
  }
}
