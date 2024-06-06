import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/core/utils/colors.dart';
import 'package:todo_list/presentation/bloc/task_bloc.dart';
import 'package:todo_list/presentation/bloc/task_event.dart';
import 'package:todo_list/presentation/bloc/task_states.dart';
import 'package:todo_list/presentation/components/custom_btn.dart';
import 'package:todo_list/presentation/components/filter_tap_widget.dart';
import 'package:todo_list/presentation/components/task_list.dart';
import 'package:todo_list/presentation/components/text_form_field.dart';
import 'package:intl/intl.dart';

import '../../core/utils/enums.dart';
import '../../domain/entity/task_entity.dart';

class CreateTaskBottomSheet extends StatelessWidget {
  const CreateTaskBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _dueDateController = TextEditingController();
    final _formKey = GlobalKey<FormState>();


    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 35,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
              const Text(
              'Create New Task',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hint: 'task title',
                  label: 'Title',
                  controller: _titleController,
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hint: 'Due date',
                  label: 'Due Date',
                  controller: _dueDateController,
                  inputType: TextInputType.datetime,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025, 12, 31),
                    ).then((value) {
                      if (value != null) {
                        _dueDateController.text = DateFormat('yyyy-MM-dd').format(value);
                      }
                    });
                  },
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final task = TaskEntity(
                        id: DateTime.now().toString(), // Generate a unique ID
                        title: _titleController.text,
                        isCompleted: false,
                        dueDate: _dueDateController.text,
                      );

                      context.read<TaskBloc>().add(AddTaskEvent(task));
                      Navigator.pop(context); // Close the bottom sheet
                    }
                  },
                  child: const Text(
                    'Save Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}