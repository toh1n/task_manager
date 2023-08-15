import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/utils/urls.dart';

class OtpVerifyController extends GetxController{
  bool _verifyInProgress = false;
  bool get verifyInProgress => _verifyInProgress;

  Future<bool> verifyOtp(String otp) async {
    _verifyInProgress = true;
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String email = sharedPrefs.getString('email')!;
    update();

    String otpUrl = "${Urls.resetPassOTP}$email/$otp";
    final NetworkResponse response = await NetworkCaller()
        .verifyEmailRequest(otpUrl);
    _verifyInProgress = false;
    update();
    if (response.body?["status"] == "success") {
      await AuthUtility.saveString('otp',otp);
      return true;
    } else {
      return false;
    }
  }
}