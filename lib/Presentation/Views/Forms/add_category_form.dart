import 'package:flutter/material.dart';
import 'package:flutter_todo_web_desktop/Data/Models/category_model.dart';
import 'package:flutter_todo_web_desktop/Presentation/ViewModels/category_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddCategoryForm extends StatefulWidget {
  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📝 Add New Category",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              _buildTextField("Title", _titleController),
              SizedBox(height: 12),
              _buildTextField("Description", _descriptionController, maxLines: 3),
              SizedBox(height: 12),
              _buildDatePicker(context),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final title = _titleController.text.trim();
                      final description = _descriptionController.text.trim();
                      final date = _selectedDate ?? DateTime.now();
  
                      if (title.isNotEmpty && description.isNotEmpty) {
                        final category = CategoryModel(
                          id: Uuid().v4(),
                          title: title,
                          description: description,
                          date: date,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        context.read<CategoryViewModel>().addNewCategory(category);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          _selectedDate == null
              ? "Select Date"
              : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}