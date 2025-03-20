import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/constants/images.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/category_view_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/todo_view_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/add_todo_diablog.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/task_cart.dart';
import 'package:flutter_todo_web_desktop/Presentation/Views/Category/Widgets/todo_item.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({
    super.key,
    required this.category,
    this.onCategoryDeleted,
  });

  final CategoryModel category;
  final VoidCallback? onCategoryDeleted;
  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  late TodoViewModel _todoViewModel;
  int _completedTasks = 0;
  int _totalTasks = 0;

  @override
  void initState() {
    super.initState();
    _todoViewModel = GetIt.instance<TodoViewModel>();
    _completedTasks = widget.category.completedTasks;
    _totalTasks = widget.category.totalTasks;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _todoViewModel.loadTodos(categoryId: widget.category.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final todoViewModel = GetIt.instance<TodoViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      todoViewModel.loadTodos(categoryId: widget.category.id);
    });

    return ChangeNotifierProvider.value(
      value: todoViewModel,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: screenSize.height,
            minWidth: screenSize.width,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Images.appBackgroundImage,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.3),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Card(
                  elevation: 4,
                  color: theme.colorScheme.surface.withValues(alpha: 0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.category,
                              color: theme.colorScheme.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Detail of Category",
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Consumer<TodoViewModel>(
                          builder: (context, todoViewModel, child) {
                            if (!todoViewModel.isLoading &&
                                todoViewModel.todos.isNotEmpty) {
                              _totalTasks = todoViewModel.todos.length;
                              _completedTasks = todoViewModel.todos
                                  .where((todo) => todo.isCompleted)
                                  .length;
                            }

                            return TaskCard(
                              title: widget.category.title,
                              completedTasks: _completedTasks,
                              totalTasks: _totalTasks,
                              onAddPressed: () =>
                                  onAddPressed(context, todoViewModel),
                              onMorePressed: () => onMorePressed(context),
                            );
                          },
                        ),
                        Consumer<TodoViewModel>(
                          builder: (context, todoViewModel, child) {
                            if (todoViewModel.isLoading) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (todoViewModel.error != null) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Error: ${todoViewModel.error}',
                                    style: TextStyle(
                                        color: theme.colorScheme.error),
                                  ),
                                ),
                              );
                            }

                            final todos = todoViewModel.todos;

                            if (todos.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.task_alt,
                                        size: 48,
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.5),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No tasks yet',
                                        style: theme.textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Add a task to get started',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: theme.colorScheme.onSurface
                                              .withValues(alpha: 0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      'Tasks',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: todos.length,
                                    separatorBuilder: (context, index) =>
                                        const Divider(height: 1),
                                    itemBuilder: (context, index) {
                                      final todo = todos[index];
                                      return TodoItem(
                                        todo: todo,
                                        onToggleCompleted: (completed) {
                                          final updatedTodo = todo.copyWith(
                                            isCompleted: completed,
                                            updatedAt:
                                                DateTime.now().toString(),
                                          );
                                          todoViewModel
                                              .updateTodoItem(updatedTodo);
                                        },
                                        onDelete: () {
                                          todoViewModel.deleteTodo
                                              .excute(todo.id);
                                          setState(() {
                                            _totalTasks -= 1;
                                            if (todo.isCompleted) {
                                              _completedTasks -= 1;
                                            }
                                          });
                                        },
                                        onEdit: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AddTaskDialog(
                                              categoryId: widget.category.id,
                                              todo: todo,
                                              onTaskAdded: (updatedTask) {
                                                todoViewModel.updateTodoItem(
                                                    updatedTask);
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onAddPressed(BuildContext context, TodoViewModel viewModel) {
    print("onAddPressed");
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        categoryId: widget.category.id,
        onTaskAdded: (newTask) {
          viewModel.createTodo(newTask);

          setState(() {
            _totalTasks += 1;
          });
        },
      ),
    );
  }

void onMorePressed(BuildContext context) {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final Offset position = button.localToGlobal(Offset.zero);

  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy + button.size.height,
      0,
      0,
    ),
    items: [
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete, size: 20),
            SizedBox(width: 8),
            Text('Delete Category'),
          ],
        ),
      ),
    ],
  ).then((value) async {
    if (value == null) return;
    if (value == 'delete') {
      final confirm = await showDialog<bool>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text('Delete'),
            ),
          ],
        ),
      );

      if (confirm == true && context.mounted) {
        final categoryViewModel = context.read<CategoryViewModel>();
        try {
          print('Starting delete process for category: ${widget.category.id}');
          await categoryViewModel.deleteCategoryById(widget.category.id);
          print('Delete completed, error: ${categoryViewModel.categoryState.error}');

          if (categoryViewModel.categoryState.error == null && context.mounted) {
            print('Clearing selected category via callback');
            widget.onCategoryDeleted?.call();
          } else if (context.mounted) {
            print('Showing error snackbar');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error: ${categoryViewModel.categoryState.error ?? "Failed to delete category"}',
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        } catch (e) {
          print('Caught exception: $e');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        }
      } else {
        print('Confirm was $confirm or context not mounted');
      }
    }
  });
}
}