import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/presentation/bloc/task_bloc.dart';
import 'package:todo_list/presentation/screens/home_screen.dart';

import 'core/services/services_locator.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocProvider<TaskBloc>(
              create: (context) => sl<TaskBloc>()..getTasksUseCase..addTaskUseCase..finishTaskUseCase,
              child: HomeScreen(),
            ),
          );
        });
  }
}
