import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/core/utils/colors.dart';
import 'package:todo_list/presentation/bloc/task_bloc.dart';
import 'package:todo_list/presentation/bloc/task_event.dart';
import 'package:todo_list/presentation/bloc/task_states.dart';
import 'package:todo_list/presentation/components/custom_btn.dart';
import 'package:todo_list/presentation/components/custom_task_btn_sheet.dart';
import 'package:todo_list/presentation/components/filter_tap_widget.dart';
import 'package:todo_list/presentation/components/task_list.dart';
import 'package:todo_list/presentation/components/text_form_field.dart';
import 'package:intl/intl.dart';

import '../../core/utils/enums.dart';
import '../../domain/entity/task_entity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String greetBasedOnTime() {
      final now = DateTime.now();
      if (now.hour < 12) {
        return 'Good Morning';
      } else if (now.hour < 18) {
        return 'Good Afternoon';
      } else {
        return 'Good Evening';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          greetBasedOnTime(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          final taskBloc = BlocProvider.of<TaskBloc>(context);
          if (state is TaskInitial) {
            taskBloc.add(LoadTasksEvent());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: const [
                        FilterButton(
                          filter: TaskFilter.all,
                          text: 'All',
                        ),
                        SizedBox(width: 3),
                        FilterButton(
                          filter: TaskFilter.notDone,
                          text: 'Not Done',
                        ),
                        SizedBox(width: 3),
                        FilterButton(
                          filter: TaskFilter.done,
                          text: 'Done',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 500,
                      child: TaskListWidget(state: state),
                    ),
                  ],
                ),
                CustomButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return BlocProvider.value(
                          value: taskBloc,
                          child: const CreateTaskBottomSheet(),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Create Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}




