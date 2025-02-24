import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Data/DataSource/TodoLocalDataSource.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/TodoViewModel.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../Core/UseCase/UseCase.dart';
import '../../Domain/Repositories/TodoRepository.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<TodoViewModel>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Todos')),
        body: Consumer<TodoViewModel>(
          builder: (context, viewModel, child) {
            final state = viewModel.state;

            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(
                  child: Text(
                      state.error ?? "loading failed: something went wrong!"));
            }
            // return TodoList(todos: state.todos);
            return Container();
          },
        ),
      ),
    );
  }
}

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => TodoViewModel(
      getTodos: sl(),
      addTodo: sl(),
      updateTodo: sl(),
      deleteTodo: sl(),
      togglePin: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => TogglePin(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodolocaldatasourceImpl(todoBox: sl()),
  );

  // External
  final todoBox = await Hive.openBox<Map>('todos');
  sl.registerLazySingleton(() => todoBox);
}