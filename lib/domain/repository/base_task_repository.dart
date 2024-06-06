


import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/domain/entity/task_entity.dart';


abstract class TaskRepository {
  Future<Either<Failure, void>> addTask(TaskEntity task);
  Future<Either<Failure, void>> finishTask(String taskId);
  Future<Either<Failure, void>> updateTaskCompletion(String taskId, bool isCompleted);
  Future<Either<Failure, List<TaskEntity>>> getTasks();
}