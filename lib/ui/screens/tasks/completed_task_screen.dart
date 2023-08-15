import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utils/manage_task_data_utility.dart';
import 'package:task_manager/ui/state_managers/completed_task_controller.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  final CompletedTaskController _completedTaskController = Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _completedTaskController.getCompletedTasks();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<CompletedTaskController>(
              builder: (_) {
                return Expanded(
                  child: _completedTaskController.getCompletedTasksProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount: _completedTaskController.taskListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: _completedTaskController.taskListModel.data![index],
                              onDeleteTap: () {
                                ManageDataUtility.showDeleteAlertDialog(context, _completedTaskController.taskListModel.data![index].sId!, _completedTaskController.taskListModel, () {
                                  setState(() {});
                                });
                              },
                              onEditTap: () {
                                ManageDataUtility.showStatusUpdateBottomSheet(context, _completedTaskController.taskListModel.data![index], () { _completedTaskController.getCompletedTasks();});
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
