import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/core/usecase/base_use_case.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/domain/repository/base_task_repository.dart';

class AddTaskUseCase extends BaseUseCase<void, TaskEntity> {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TaskEntity parameters) async {
    return await repository.addTask(parameters);
  }
}



