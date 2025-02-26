import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Core/UseCase/category_use_case.dart';
import 'package:flutter_todo_web_desktop/Data/DataSource/todo_local_data_source.dart';
import 'package:flutter_todo_web_desktop/Domain/Repositories/category_repository.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/category_view_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Forms/add_category_form.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<CategoryViewModel>()..loadCategories(),
      child: Scaffold(
        appBar: AppBar(title: Text("Category Manager")),
        floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => ChangeNotifierProvider.value(value: context.read<CategoryViewModel>, child: Dialog(child: AddCategoryForm(),),)),
            child: Icon(Icons.add)),
        body: Column(
          children: [
            Expanded(
              child: Consumer<CategoryViewModel>(
                builder: (context, viewModel, child) {
                  final state = viewModel.categoryState;

                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(child: Text("❌ Error: ${state.error}"));
                  }

                  final categories = state.categories;

                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ListTile(
                        title: Text(category.title),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => CategoryViewModel(
      addCategory: sl(),
      updateCategory: sl(),
      deleteCategory: sl(),
      getCategories: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => AddCategory(sl()));
  sl.registerLazySingleton(() => UpdateCategory(sl()));
  sl.registerLazySingleton(() => DeleteCategory(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));

  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodolocaldatasourceImpl(todoBox: sl(), categoryBox: sl()),
  );

  // External
  final todoBox = await Hive.openBox<Map>('categoryKey');
  sl.registerLazySingleton(() => todoBox);
}
