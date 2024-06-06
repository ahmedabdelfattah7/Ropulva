import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/usecase/base_use_case.dart';
import 'package:todo_list/domain/repository/base_task_repository.dart';

class UpdateTaskCompletionUseCase {
  final TaskRepository repository;

  UpdateTaskCompletionUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateTaskCompletionParams params) {
    return repository.updateTaskCompletion(params.taskId, params.isCompleted);
  }
}

class UpdateTaskCompletionParams {
  final String taskId;
  final bool isCompleted;

  UpdateTaskCompletionParams({
    required this.taskId,
    required this.isCompleted,
  });
}
