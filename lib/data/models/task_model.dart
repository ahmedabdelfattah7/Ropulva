import 'package:todo_list/domain/entity/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required String id,
    required String title,
    required bool isCompleted,
    required String dueDate,
  }) : super(
          id: id,
          title: title,
          isCompleted: isCompleted,
          dueDate: dueDate,
        );

  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
      dueDate: task.dueDate,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      dueDate: json['dueDate'],
    );
  }
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      isCompleted: isCompleted,
      dueDate: dueDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'dueDate': dueDate,
    };
  }
}
