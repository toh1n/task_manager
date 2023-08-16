import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCanceledTasksProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCanceledTasksProgress => _getCanceledTasksProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCanceledTasks() async {
    _getCanceledTasksProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.canceledTasks);
    _getCanceledTasksProgress = false;
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
