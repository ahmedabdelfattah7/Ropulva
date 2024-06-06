import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String dueDate;
  final bool isCompleted;

  TaskEntity({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.isCompleted,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? dueDate,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, dueDate, isCompleted];
}
