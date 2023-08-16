import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/ui/state_managers/widget_controllers/update_task_status_controller.dart';

class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet(
      {Key? key, required this.task, required this.onUpdate})
      : super(key: key);

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
  late String _selectedTask;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(16), child: Text('Update Status')),
          Expanded(
            child: ListView.builder(
                itemCount: taskStatusList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _selectedTask = taskStatusList[index];
                      setState(() {});
                    },
                    title: Text(taskStatusList[index].toUpperCase()),
                    trailing: _selectedTask == taskStatusList[index]
                        ? const Icon(Icons.check)
                        : null,
                  );
                }),
          ),
          GetBuilder<UpdateTaskStatusController>(
              builder: (updateTaskStatusController) {
            return Padding(
                padding: const EdgeInsets.all(16),
                child: Visibility(
                    visible: updateTaskStatusController.updateTaskInProgress ==
                        false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          updateTaskStatusController
                              .updateTask(widget.task.sId!, _selectedTask)
                              .then((value) {
                            if (value) {
                              Get.snackbar("Success", "Task updated status Successfully");
                              widget.onUpdate();
                              Navigator.pop(context);
                            } else {
                              Get.snackbar("Failed",
                                  "Updating task status has failed");
                            }
                          });
                        },
                        child: const Text('Update'))));
          })
        ],
      ),
    );
  }
}
