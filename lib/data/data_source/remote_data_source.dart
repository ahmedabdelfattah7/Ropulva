import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/data/models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<void> addTask(TaskModel task);
  Future<void> finishTask(String taskId);
  Future<List<TaskModel>> getTasks();
  Future<void> updateTaskCompletion(String taskId, bool isCompleted);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  @override
  Future<void> addTask(TaskModel task) async {
    await FirebaseFirestore.instance.collection('tasks').add(task.toJson());
  }

  @override
  Future<void> finishTask(String taskId) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({'isCompleted': true});
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
      .collection('tasks')
          .orderBy('id', descending: true)
          .get();
      querySnapshot.docs.forEach((doc) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
      });
      return querySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }
  @override
  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .update({'isCompleted': isCompleted});
    } catch (e) {
      print('Failed to update task completion status: $e');
    }
  }
}
