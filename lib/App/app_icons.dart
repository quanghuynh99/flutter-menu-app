import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/constants/images.dart';

class AppIcons {
  AppIcons._();
  static List<Map<String, dynamic>> topicIcons = [
    {'name': 'category', 'icon': Icons.category},
    {'name': 'work', 'icon': Icons.work},
    {'name': 'home', 'icon': Icons.home},
    {'name': 'shopping', 'icon': Icons.shopping_cart},
    {'name': 'health', 'icon': Icons.favorite},
    {'name': 'travel', 'icon': Icons.flight},
    {'name': 'education', 'icon': Icons.school},
    {'name': 'entertainment', 'icon': Icons.movie},
    {'name': 'finance', 'icon': Icons.account_balance},
    {'name': 'food', 'icon': Icons.restaurant},
  ];

  static List<Map<String, dynamic>> topicBackgroundImages = [
    {'name': 'category', 'icon': AssetImage('')},
    {'name': 'work', 'icon': AssetImage('')},
    {'name': 'home', 'icon': AssetImage('')},
    {'name': 'shopping', 'icon': AssetImage('')},
    {'name': 'health', 'icon': AssetImage(Images.healthBackgroundImage)},
    {'name': 'travel', 'icon': AssetImage('')},
    {'name': 'education', 'icon': AssetImage('')},
    {'name': 'entertainment', 'icon': AssetImage('')},
    {'name': 'finance', 'icon': AssetImage('')},
    {'name': 'food', 'icon': AssetImage('')},
  ];
}
