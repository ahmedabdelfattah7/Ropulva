import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/data/data_source/remote_data_source.dart';
import 'package:todo_list/data/models/task_model.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/domain/repository/base_task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      final result = await remoteDataSource.addTask(TaskModel.fromEntity(task));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to add task'));
    }
  }

  @override
  Future<Either<Failure, void>> finishTask(String taskId) async {
    try {
      final result = await remoteDataSource.finishTask(taskId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to finish task'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final tasks = await remoteDataSource.getTasks();
      return Right(tasks.map((task) => task.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure('Failed to fetch tasks'));
    }
  }
  @override
  Future<Either<Failure, void>> updateTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await remoteDataSource.updateTaskCompletion(taskId, isCompleted);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update task completion status'));
    }
  }
}
