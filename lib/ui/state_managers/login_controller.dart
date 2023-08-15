import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/utils/urls.dart';

class LoginController extends GetxController{

  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  Future<bool> login(String email,String password) async {
    _loginInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);
    _loginInProgress = false;
    if (response.isSuccess) {
      await AuthUtility.saveUserInfo(LoginModel.fromJson(response.body!));
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}