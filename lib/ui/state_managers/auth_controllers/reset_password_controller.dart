import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/utils/urls.dart';

class ResetPasswordController extends GetxController{
  bool _resetPasswordInProgress = false;

  bool get resetPasswordInProgress => _resetPasswordInProgress;

  Future<bool> resetPassword(String password) async{
    _resetPasswordInProgress = true;
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? email = sharedPrefs.getString('email');
    String? otp = sharedPrefs.getString('otp');
    update();

    Map<String,dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password
    };



    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.resetPass, requestBody);

    _resetPasswordInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthUtility.clearUserInfo();
      return true;
    } else {
      return false;
    }
  }
}
