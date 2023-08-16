import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateTaskStatusController extends GetxController {
  bool _updateTaskInProgress = false;
  bool get updateTaskInProgress => _updateTaskInProgress;

  Future<bool> updateTask(String taskId, String newStatus) async {
    _updateTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    _updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      update();
      return true;
    } else {
      return false;
    }
  }
}
