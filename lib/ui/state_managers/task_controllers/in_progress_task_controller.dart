import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';

class InProgressTaskController extends GetxController {
  bool _getProgressTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTasksInProgress => _getProgressTasksInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getInProgressTasks() async {
    _getProgressTasksInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTasks);
    _getProgressTasksInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
