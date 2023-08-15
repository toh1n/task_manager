import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utils/manage_task_data_utility.dart';
import 'package:task_manager/ui/screens/tasks/add_new_task_screen.dart';
import 'package:task_manager/ui/state_managers/task_controllers/new_task_controller.dart';
import 'package:task_manager/ui/state_managers/task_controllers/summary_count_controller.dart';
import 'package:task_manager/ui/widgets/summary_card.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  final SummaryCountController _summaryCountController = Get.find<SummaryCountController>();
  final NewTaskController _newTaskController = Get.find<NewTaskController>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getCountSummary();
      _newTaskController.getNewTasks();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<SummaryCountController>(builder: (_) {

              if(_summaryCountController.getCountSummaryInProgress){
                return const LinearProgressIndicator();
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _summaryCountController.summaryCountModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return SummaryCard(
                        title: _summaryCountController.summaryCountModel.data![index].sId ?? 'New',
                        number: _summaryCountController.summaryCountModel.data![index].sum ?? 0,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 4,
                      );
                    },
                  ),
                ),
              );

            }),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _summaryCountController.getCountSummary().then((value){
                    if(!value){
                      Get.snackbar("Failed", "Failed to get summery");
                    }
                  });
                  _newTaskController.getNewTasks().then((value){
                    if(!value){
                      Get.snackbar("Failed", "Failed to get summery");
                    }
                  });

                },
                child: GetBuilder<NewTaskController>(
                  builder: (_) {
                    if(_newTaskController.getNewTaskInProgress){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.separated(
                            itemCount: _newTaskController.taskListModel.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return TaskListTile(
                                data: _newTaskController.taskListModel.data![index],
                                onDeleteTap: () {
                                  ManageDataUtility.showDeleteAlertDialog(context, _newTaskController.taskListModel.data![index].sId!, _newTaskController.taskListModel,() {
                                    setState(() {});
                                  },);
                                  if(mounted){
                                    setState(() {

                                    });
                                  }

                                },
                                onEditTap: () {
                                  ManageDataUtility.showStatusUpdateBottomSheet(context,_newTaskController.taskListModel.data![index],() {
                                    _newTaskController.getNewTasks();
                                  },);
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const Divider(
                                height: 4,
                              );
                            },
                          );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(const AddNewTaskScreen());

        },
      ),
    );
  }

}
