import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/utils/urls.dart';

class EmailVerifyController extends GetxController{

  bool _verifyInProgress = false;
  bool get verifyInProgress => _verifyInProgress;

  Future<bool> verifyEmail(String email) async {
    _verifyInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller()
        .verifyEmailRequest("${Urls.verifyEmail}$email");
    _verifyInProgress = false;
    update();
    if (response.body?["status"] == "success") {
      await AuthUtility.saveString('email',email);
      return true;
    } else {
      return false;
    }
  }


}