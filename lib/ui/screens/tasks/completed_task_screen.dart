import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/manage_task_data_utility.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTasks = false;
  TaskListModel _taskListModel = TaskListModel();
  Future<void> getCompletedTasks() async {
    _getCompletedTasks = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Completed tasks get failed')));
      }
    }
    _getCompletedTasks = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCompletedTasks();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            Expanded(
              child: _getCompletedTasks
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemCount: _taskListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data: _taskListModel.data![index],
                          onDeleteTap: () {
                            ManageDataUtility.showDeleteAlertDialog(context, _taskListModel.data![index].sId!, _taskListModel, () {
                              setState(() {});
                            });
                          },
                          onEditTap: () {
                            ManageDataUtility.showStatusUpdateBottomSheet(context, _taskListModel.data![index], () { getCompletedTasks();});
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 4,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
