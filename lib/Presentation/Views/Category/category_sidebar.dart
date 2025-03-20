import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/app_icons.dart';
import 'package:flutter_todo_web_desktop/App/constants/sizes.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/category_view_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/add_category_dialog.dart';
import 'package:provider/provider.dart';

class CategorySidebar extends StatefulWidget {
  final CategoryModel? selectedCategory;
  final Function(CategoryModel) onCategorySelected;

  const CategorySidebar({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategorySidebar> createState() => _CategorySidebarState();
}

class _CategorySidebarState extends State<CategorySidebar> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryViewModel>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) {
        print(
            'Building CategorySidebar, categories: ${viewModel.categoryState.categories.map((c) => c.id).toList()}');
        return LayoutBuilder(builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final bool isExpanded = screenWidth > 700;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isExpanded ? 240 : 56,
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: ElevatedButton(
                    onPressed: () => _showAddCategoryDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: isExpanded ? 16 : 8,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide.none,
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 20, color: Colors.white),
                        if (isExpanded) ...[
                          const SizedBox(width: 8),
                          Text(
                            "Add Category",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: viewModel.categoryState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.categoryState.error != null
                          ? Center(
                              child: Text(
                                  "Error: ${viewModel.categoryState.error}"))
                          : viewModel.categoryState.categories.isEmpty
                              ? Center(
                                  child: isExpanded
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.all(TSizes.md),
                                          child: Text(
                                            "Chưa có danh mục, hãy thêm một danh mục!",
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                        )
                                      : null,
                                )
                              : ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  itemCount:
                                      viewModel.categoryState.categories.length,
                                  itemBuilder: (context, index) {
                                    final category = viewModel
                                        .categoryState.categories[index];
                                    final isSelected =
                                        widget.selectedCategory?.id ==
                                            category.id;
                                    print(
                                        "category.title ------- ${category.title}");

                                    return ListTile(
                                      leading: Icon(
                                        AppIcons.topicIcons.firstWhere(
                                          (item) =>
                                              item['name'] == category.icon,
                                          orElse: () =>
                                              {'icon': Icons.help_outline},
                                        )['icon'] as IconData,
                                        size: 24,
                                        color: isSelected
                                            ? Colors.blueAccent
                                            : Colors.grey.shade700,
                                      ),
                                      title: isExpanded
                                          ? Text(
                                              category.title,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                                color: isSelected
                                                    ? Colors.blueAccent
                                                    : Colors.black87,
                                              ),
                                            )
                                          : null,
                                      selected: isSelected,
                                      selectedTileColor: Colors.grey.shade200,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                      minVerticalPadding: 0,
                                      dense: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      onTap: () =>
                                          widget.onCategorySelected(category),
                                    );
                                  },
                                ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AddCategoryDialog(
        addOnCategory: (newCategory) {
          context.read<CategoryViewModel>().addNewCategory(newCategory);
        },
      ),
    );
  }
}
