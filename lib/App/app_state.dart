import 'package:flutter_todo_web_desktop/Domain/Repositories/todo_repository.dart';
import 'package:flutter_todo_web_desktop/Domain/UseCase/category_use_case.dart';
import 'package:flutter_todo_web_desktop/Data/DataSource/todo_local_data_source.dart';
import 'package:flutter_todo_web_desktop/Domain/Repositories/category_repository.dart';
import 'package:flutter_todo_web_desktop/Domain/UseCase/todo_use_case.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/category_view_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/todo_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> initAppState() async {
  try {
    await Hive.initFlutter();
    final todoBox = await Hive.openBox<Map>('todos');
    final categoryBox = await Hive.openBox<Map>('categories');

    sl.registerLazySingleton(() => todoBox, instanceName: 'todoBox');
    sl.registerLazySingleton(() => categoryBox, instanceName: 'categoryBox');

    // Data Sources
    sl.registerLazySingleton<TodoLocalDataSource>(
      () => TodolocaldatasourceImpl(
        todoBox: sl(instanceName: 'todoBox'),
        categoryBox: sl(instanceName: 'categoryBox'),
      ),
    );

    // Repository
    sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl()),
    );

    // Use Cases
    sl.registerLazySingleton(() => AddCategory(sl()));
    sl.registerLazySingleton(() => UpdateCategory(sl()));
    sl.registerLazySingleton(() => DeleteCategory(sl()));
    sl.registerLazySingleton(() => GetCategories(sl()));

    // ViewModel
    sl.registerFactory(
      () => CategoryViewModel(
        addCategory: sl(),
        updateCategory: sl(),
        deleteCategory: sl(),
        getCategories: sl(),
      ),
    );
  } catch (e, stackTrace) {
    print("Error in init: $e");
    print("StackTrace: $stackTrace");
    rethrow;
  }
}

Future<void> registerTodoViewModel() async {
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => GetTodos(sl()));

  sl.registerFactory(() => TodoViewModel(
      addTodo: sl(), updateTodo: sl(), deleteTodo: sl(), getTodos: sl()));
}
