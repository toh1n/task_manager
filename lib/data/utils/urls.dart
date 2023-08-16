class Urls {
  Urls._();

  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTasks = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String verifyEmail = '$_baseUrl/RecoverVerifyEmail/';
  static String resetPass = '$_baseUrl/RecoverResetPass';
  static String resetPassOTP = '$_baseUrl/RecoverVerifyOTP/';
  static String profileUpdate = '$_baseUrl/profileUpdate/';
  static String canceledTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static String completedTasks = '$_baseUrl/listTaskByStatus/Completed';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}
