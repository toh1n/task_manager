import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/urls.dart';

class SignUpController extends GetxController{

  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  Future<bool> userSignUp(String email,String password,String firsName, String lastName, String mobile,) async {
    _signUpInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firsName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.registration, requestBody);
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

}