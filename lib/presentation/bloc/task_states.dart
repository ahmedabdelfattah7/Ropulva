import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/core/utils/enums.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/presentation/bloc/task_event.dart';


abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}


class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

class TaskLoaded extends TaskState {
  final List<TaskEntity> allTasks;
  final List<TaskEntity> doneTasks;
  final List<TaskEntity> notDoneTasks;
  final TaskFilter filter;

  const TaskLoaded({
    required this.allTasks,
    required this.doneTasks,
    required this.notDoneTasks,
    this.filter = TaskFilter.all,
  });

  @override
  List<Object?> get props => [allTasks, doneTasks, notDoneTasks, filter];
}

