import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/theme/theme.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/category_view_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/category_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CategoryManagerApp extends StatelessWidget {
  const CategoryManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GetIt.instance<CategoryViewModel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Categories",
        themeMode: ThemeMode.light,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const CategoryScreen(),
      ),
    );
  }
}
