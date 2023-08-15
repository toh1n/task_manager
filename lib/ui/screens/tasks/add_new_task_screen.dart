import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager/ui/state_managers/task_controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/widgets/my_button.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileAppBar(),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Add new task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(hintText: 'Title'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 4,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GetBuilder<AddNewTaskController>(
                        builder: (addNewTaskController) {
                      return MyButton(
                          visible: addNewTaskController.adNewTaskInProgress,
                          voidCallback: () {
                            if (_formKey.currentState!.validate()) {
                              addNewTaskController
                                  .addNewTask(_titleTEController.text.trim(),
                                      _descriptionTEController.text.trim())
                                  .then((value) {
                                if (value) {
                                  Get.snackbar(
                                      "Success", "New Task added Successfully");
                                  Get.offAll(const BottomNavBaseScreen());
                                } else {
                                  Get.snackbar(
                                      "Failed", "Failed to add new task");
                                }
                              });
                            }
                          });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
