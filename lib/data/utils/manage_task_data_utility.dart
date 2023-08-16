import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/update_task_status_sheet.dart';
import 'package:get/get.dart';

class ManageDataUtility {
  ManageDataUtility._();

  static void showStatusUpdateBottomSheet(
      BuildContext context, TaskData task, VoidCallback onUpdate) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(
          task: task,
          onUpdate: onUpdate,
        );
      },
    );
  }

  static Future<bool> _deleteTask(BuildContext context, String taskId,
      TaskListModel taskListModel, VoidCallback onUpdate) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      taskListModel.data!.removeWhere((element) => element.sId == taskId);
      onUpdate();
      return true;
    } else {
      return false;
    }
  }

  static void showDeleteAlertDialog(BuildContext context, String taskId,
      TaskListModel taskListModel, VoidCallback onUpdate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete?'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _deleteTask(context, taskId, taskListModel, onUpdate)
                    .then((value) {
                  if (value) {
                    Get.snackbar("Success", "Successfully deleted");
                  } else {
                    Get.snackbar("Failed", "Failed to deleted");
                  }
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );
  }
}
