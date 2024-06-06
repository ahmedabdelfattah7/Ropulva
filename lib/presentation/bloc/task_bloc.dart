import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/usecase/base_use_case.dart';
import 'package:todo_list/core/utils/enums.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/domain/usecases/add_task_usecase.dart';
import 'package:todo_list/domain/usecases/finish_task_usecase.dart';
import 'package:todo_list/domain/usecases/get_tasks_usecases.dart';
import 'package:todo_list/domain/usecases/update_use_case.dart';
import 'package:todo_list/presentation/bloc/task_event.dart';
import 'package:todo_list/presentation/bloc/task_states.dart';
import 'package:todo_list/core/error/failure.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final FinishTaskUseCase finishTaskUseCase;
  final UpdateTaskCompletionUseCase updateTaskCompletionUseCase;

  TaskBloc({
    required this.updateTaskCompletionUseCase,
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.finishTaskUseCase,
  }) : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<FinishTaskEvent>(_onFinishTask);
    on<FilterTasksEvent>(_onFilterTasks);
    on<TaskCompletionChangedEvent>(_onTaskCompletionChanged);
  }

  Future<void> _onLoadTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await getTasksUseCase(NoParameters());
    result.fold(
          (failure) => emit(TaskError(_mapFailureToMessage(failure))),
          (tasks) {
        final doneTasks = tasks.where((task) => task.isCompleted).toList();
        final notDoneTasks = tasks.where((task) => !task.isCompleted).toList();
        emit(TaskLoaded(allTasks: tasks, doneTasks: doneTasks, notDoneTasks: notDoneTasks));
      },
    );
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await addTaskUseCase(event.task);
    result.fold(
          (failure) => emit(TaskError(_mapFailureToMessage(failure))),
          (_) => add(LoadTasksEvent()),
    );
  }

  Future<void> _onFinishTask(FinishTaskEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final result = await finishTaskUseCase(event.taskId);
      result.fold(
            (failure) => emit(TaskError(_mapFailureToMessage(failure))),
            (_) => add(LoadTasksEvent()),
      );
    }
  }

  Future<void> _onTaskCompletionChanged(TaskCompletionChangedEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final result = await updateTaskCompletionUseCase(UpdateTaskCompletionParams(taskId: event.taskId, isCompleted: event.isCompleted));
      result.fold(
              (failure) => emit(TaskError(_mapFailureToMessage(failure))),
              (_) {
            final updatedTasks = currentState.allTasks.map((task) {
              if (task.id == event.taskId) {
                task = task.copyWith(isCompleted: event.isCompleted);
              }
              return task;
            }).toList();
            final doneTasks = updatedTasks.where((task) => task.isCompleted).toList();
            final notDoneTasks = updatedTasks.where((task) => !task.isCompleted).toList();
            emit(TaskLoaded(allTasks: updatedTasks, doneTasks: doneTasks, notDoneTasks: notDoneTasks, filter: currentState.filter));
          }
      );
    }
  }


  void _onFilterTasks(FilterTasksEvent event, Emitter<TaskState> emit) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      List<TaskEntity> filteredTasks;
      switch (event.filter) {
        case TaskFilter.done:
          filteredTasks = currentState.doneTasks;
          break;
        case TaskFilter.notDone:
          filteredTasks = currentState.notDoneTasks;
          break;
        case TaskFilter.all:
        default:
          filteredTasks = currentState.allTasks;
          break;
      }
      emit(TaskLoaded(
        allTasks: currentState.allTasks,
        doneTasks: currentState.doneTasks,
        notDoneTasks: currentState.notDoneTasks,
        filter: event.filter,
      ));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}







