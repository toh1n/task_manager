import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utils/manage_task_data_utility.dart';
import 'package:task_manager/ui/state_managers/cancelled_task_controller.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {


  final CancelledTaskController _cancelledTaskController = Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cancelledTaskController.getCanceledTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<CancelledTaskController>(
              builder: (_) {
                return Expanded(
                  child: _cancelledTaskController.getCanceledTasksProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount: _cancelledTaskController.taskListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: _cancelledTaskController.taskListModel.data![index],
                              onDeleteTap: () {
                                ManageDataUtility.showDeleteAlertDialog(context, _cancelledTaskController.taskListModel.data![index].sId!, _cancelledTaskController.taskListModel, () {
                                  setState(() {});
                                });
                              },
                              onEditTap: () {
                                ManageDataUtility.showStatusUpdateBottomSheet(context, _cancelledTaskController.taskListModel.data![index], () {_cancelledTaskController.getCanceledTasks(); });
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
