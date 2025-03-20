import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/App/constants/sizes.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final int completedTasks;
  final int totalTasks;
  final VoidCallback onMorePressed;
  final VoidCallback onAddPressed;

  const TaskCard({
    super.key,
    required this.title,
    required this.completedTasks,
    required this.totalTasks,
    required this.onMorePressed,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = TSizes.gridViewSpacing;
        int progressValue =
            (totalTasks > 0 ? completedTasks / totalTasks * 100 : 0.0).toInt();
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade600,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: padding),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 300) {
                      return Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: TSizes.loadingIndicatorMdSize,
                                    height: TSizes.loadingIndicatorMdSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: TSizes.loadingIndicatorMdSize,
                                    height: TSizes.loadingIndicatorMdSize,
                                    child: CircularProgressIndicator(
                                      value: progressValue.toDouble(),
                                      backgroundColor:
                                          Colors.white.withValues(alpha: 0.3),
                                      color: Colors.white,
                                      strokeWidth: 4,
                                    ),
                                  ),
                                  Text(
                                    "$progressValue %",
                                    style: TextStyle(
                                        fontSize: TSizes.fontSizeMn,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: padding),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  "$completedTasks/$totalTasks tasks",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: padding),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: onMorePressed,
                                icon: Icon(Icons.more_horiz,
                                    color: Colors.white, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              SizedBox(width: padding * 0.5),
                              IconButton(
                                onPressed: onAddPressed,
                                icon: Icon(Icons.add,
                                    color: Colors.white, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: TSizes.loadingIndicatorMdSize,
                                    height: TSizes.loadingIndicatorMdSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: TSizes.loadingIndicatorMdSize,
                                    height: TSizes.loadingIndicatorMdSize,
                                    child: CircularProgressIndicator(
                                      value: progressValue.toDouble(),
                                      backgroundColor:
                                          Colors.white.withValues(alpha: 0.3),
                                      color: Colors.white,
                                      strokeWidth: 4,
                                    ),
                                  ),
                                  Text(
                                    "$progressValue %",
                                    style: TextStyle(
                                        fontSize: TSizes.fontSizeMn,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: padding),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  "$completedTasks/$totalTasks tasks",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: padding),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: onMorePressed,
                                icon: Icon(Icons.more_horiz,
                                    color: Colors.white, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              SizedBox(width: padding * 0.5),
                              IconButton(
                                onPressed: onAddPressed,
                                icon: Icon(Icons.add,
                                    color: Colors.white, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: padding),
                Text(
                  "Last updated: ${DateTime.now().toString().substring(0, 16)}",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
