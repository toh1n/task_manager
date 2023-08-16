import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utils/manage_task_data_utility.dart';
import 'package:task_manager/ui/state_managers/task_controllers/in_progress_task_controller.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final InProgressTaskController _inProgressTaskController =
      Get.find<InProgressTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _inProgressTaskController.getInProgressTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<InProgressTaskController>(builder: (context) {
              return Expanded(
                child: _inProgressTaskController.getProgressTasksInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _inProgressTaskController
                                .taskListModel.data?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: _inProgressTaskController
                                .taskListModel.data![index],
                            onDeleteTap: () {
                              ManageDataUtility.showDeleteAlertDialog(
                                  context,
                                  _inProgressTaskController
                                      .taskListModel.data![index].sId!,
                                  _inProgressTaskController.taskListModel, () {
                                setState(() {});
                              });
                            },
                            onEditTap: () {
                              ManageDataUtility.showStatusUpdateBottomSheet(
                                  context,
                                  _inProgressTaskController
                                      .taskListModel.data![index], () {
                                _inProgressTaskController.getInProgressTasks();
                              });
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
            }),
          ],
        ),
      ),
    );
  }
}
