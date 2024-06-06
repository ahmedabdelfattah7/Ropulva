import 'package:get_it/get_it.dart';
import 'package:todo_list/data/data_source/remote_data_source.dart';
import 'package:todo_list/data/repository/impl_task_repository.dart';
import 'package:todo_list/domain/repository/base_task_repository.dart';
import 'package:todo_list/domain/usecases/add_task_usecase.dart';
import 'package:todo_list/domain/usecases/finish_task_usecase.dart';
import 'package:todo_list/domain/usecases/get_tasks_usecases.dart';
import 'package:todo_list/domain/usecases/update_use_case.dart';
import 'package:todo_list/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init()  {
    // Bloc
    sl.registerFactory(() => TaskBloc(
      getTasksUseCase: sl(),
      addTaskUseCase: sl(),
      finishTaskUseCase: sl(), updateTaskCompletionUseCase:  sl(),
    ));

    // Use cases
    sl.registerLazySingleton(() => GetTasksUseCase(sl()));
    sl.registerLazySingleton(() => AddTaskUseCase(sl()));
    sl.registerLazySingleton(() => FinishTaskUseCase(sl()));
    sl.registerLazySingleton(() => UpdateTaskCompletionUseCase(sl()));
    // Repository
    sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

    //data source
    sl.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImpl());
  }
}
