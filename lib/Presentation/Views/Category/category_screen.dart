import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/category_view_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/category_detail.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/empty_state_view.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/category_sidebar.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryViewModel>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoryViewModel>(
        builder: (context, viewModel, child) {
          print('Building CategoryScreen, categories: ${viewModel.categoryState.categories.map((c) => c.id).toList()}');
          if (_selectedCategory != null &&
              !viewModel.categoryState.categories.any((c) => c.id == _selectedCategory!.id)) {
            _selectedCategory = null;
          }

          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
                child: CategorySidebar(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              ),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(
                child: _selectedCategory == null
                    ? const EmptyStateView()
                    : CategoryDetail(
                        category: _selectedCategory!,
                        onCategoryDeleted: _clearSelectedCategory,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _clearSelectedCategory() {
    setState(() {
      _selectedCategory = null;
    });
  }
}