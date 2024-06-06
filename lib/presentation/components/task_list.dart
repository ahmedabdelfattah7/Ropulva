import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/utils/enums.dart';
import 'package:todo_list/presentation/bloc/task_bloc.dart';
import 'package:todo_list/presentation/bloc/task_event.dart';
import 'package:todo_list/presentation/bloc/task_states.dart';
import 'package:todo_list/domain/entity/task_entity.dart';

class TaskListWidget extends StatelessWidget {
  final TaskState state;

  const TaskListWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is TaskLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TaskLoaded) {
      final taskLoadedState = state as TaskLoaded;
      List<TaskEntity> tasks;
      switch (taskLoadedState.filter) {
        case TaskFilter.done:
          tasks = taskLoadedState.doneTasks;
          break;
        case TaskFilter.notDone:
          tasks = taskLoadedState.notDoneTasks;
          break;
        case TaskFilter.all:
        default:
          tasks = taskLoadedState.allTasks;
          break;
      }

      if (tasks.isEmpty) {
        return const Center(child: Text('No tasks available.'));
      }

      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskItem(
            id: task.id,
            title: task.title,
            dueDate: task.dueDate,
            isCompleted: task.isCompleted,
            onTaskCompletionChanged: (bool isCompleted) {
              BlocProvider.of<TaskBloc>(context).add(
                TaskCompletionChangedEvent(
                  taskId: task.id,
                  isCompleted: isCompleted,
                ),
              );
            },
          );
        },
      );
    } else if (state is TaskError) {
      return Center(child: Text((state as TaskError).message));
    } else {
      return Container();
    }
  }
}






// TaskItem widget
class TaskItem extends StatelessWidget {
  final String id;
  final String title;
  final String dueDate;
  final bool isCompleted;
  final Function(bool) onTaskCompletionChanged;

  const TaskItem({
    Key? key,
    required this.id,
    required this.title,
    required this.dueDate,
    required this.isCompleted,
    required this.onTaskCompletionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          onTaskCompletionChanged(!isCompleted); // Toggle completion status
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      dueDate,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isCompleted ? Icons.check_circle : Icons.circle,
                  color: isCompleted ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  onTaskCompletionChanged(!isCompleted); // Toggle completion status
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}





