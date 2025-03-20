import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/app_state.dart';
import 'package:flutter_todo_web_desktop/App/splash_screen.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/category_page.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initAppState();
    await registerTodoViewModel();
    runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => CategoryManagerApp(),
      },
    ));
  } catch (e, stackTrace) {
    print("Error in main: $e");
    print("StackTrace: $stackTrace");
  }
}
