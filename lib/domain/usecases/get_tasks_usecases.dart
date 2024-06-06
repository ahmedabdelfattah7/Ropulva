import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/usecase/base_use_case.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/domain/repository/base_task_repository.dart';

class GetTasksUseCase extends BaseUseCase<List<TaskEntity>, NoParameters> {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParameters params) async {
    return await repository.getTasks();
  }
}