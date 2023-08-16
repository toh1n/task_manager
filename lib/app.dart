import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/login_controller.dart';
import 'package:task_manager/ui/state_managers/task_controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/email_verify_controller.dart';
import 'package:task_manager/ui/state_managers/task_controllers/cancelled_task_controller.dart';
import 'package:task_manager/ui/state_managers/task_controllers/completed_task_controller.dart';
import 'package:task_manager/ui/state_managers/task_controllers/in_progress_task_controller.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/otp_verify_controller.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/reset_password_controller.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/sign_up_controller.dart';
import 'package:task_manager/ui/state_managers/task_controllers/new_task_controller.dart';
import 'package:task_manager/ui/state_managers/task_controllers/summary_count_controller.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/update_profile_controller.dart';
import 'package:task_manager/ui/state_managers/widget_controllers/update_task_status_controller.dart';

class TaskManagerApp extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinding(),
      key: TaskManagerApp.globalKey,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SignUpController());
    Get.put(EmailVerifyController());
    Get.put(OtpVerifyController());
    Get.put(ResetPasswordController());
    Get.put(UpdateProfileController());
    Get.put(AddNewTaskController());
    Get.put(NewTaskController());
    Get.put(SummaryCountController());
    Get.put(CancelledTaskController());
    Get.put(InProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(UpdateTaskStatusController());
  }
}
