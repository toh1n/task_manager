import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';

class CompletedTaskController extends GetxController{
  bool _getCompletedTasksProgress = false;
  TaskListModel _taskListModel = TaskListModel();
  bool get getCompletedTasksProgress => _getCompletedTasksProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTasks() async {
    _getCompletedTasksProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTasks);
    _getCompletedTasksProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      return true;
    } else {
      return false;
    }
  }
}