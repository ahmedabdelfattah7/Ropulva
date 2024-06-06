import 'package:equatable/equatable.dart';
import 'package:todo_list/core/utils/enums.dart';
import 'package:todo_list/domain/entity/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  const AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class FinishTaskEvent extends TaskEvent {
  final String taskId;

  const FinishTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class FilterTasksEvent extends TaskEvent {
  final TaskFilter filter;

  const FilterTasksEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

class TaskCompletionChangedEvent extends TaskEvent {
  final String taskId;
  final bool isCompleted;

  const TaskCompletionChangedEvent({
    required this.taskId,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [taskId, isCompleted];
}

class UpdateTaskCompletionEvent extends Equatable {
  final String taskId;
  final bool isCompleted;

  UpdateTaskCompletionEvent({required this.taskId, required this.isCompleted});

  @override
  List<Object?> get props => [taskId, isCompleted];
}