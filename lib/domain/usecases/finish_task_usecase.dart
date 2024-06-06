import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/usecase/base_use_case.dart';
import 'package:todo_list/domain/repository/base_task_repository.dart';

class FinishTaskUseCase extends BaseUseCase<void, String> {
  final TaskRepository repository;

  FinishTaskUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String taskId) async {
    return await repository.finishTask(taskId);
  }
}

