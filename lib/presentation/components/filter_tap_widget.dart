import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/core/utils/colors.dart';
import 'package:todo_list/core/utils/enums.dart';
import 'package:todo_list/presentation/bloc/task_bloc.dart';
import 'package:todo_list/presentation/bloc/task_event.dart';
import 'package:todo_list/presentation/bloc/task_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterButton extends StatelessWidget {
  final TaskFilter filter;
  final String text;

  const FilterButton({
    Key? key,
    required this.filter,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final taskBloc = BlocProvider.of<TaskBloc>(context);
        final selectedColor = ColorCode.primary;
        final defaultColor = ColorCode.primary.withOpacity(0.1);

        final isSelected = (state is TaskLoaded && state.filter == filter);

        return InkWell(
          onTap: () {
            taskBloc.add(FilterTasksEvent(filter));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected ? selectedColor : defaultColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : ColorCode.primary,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
