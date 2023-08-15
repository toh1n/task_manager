import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController{
  // bool _profileInProgress = false;
  UserData userData = UserData();
  String image = "";
  String base64Image = "";
  // bool get profileInProgress => _profileInProgress;

  // Future<bool> updateProfile(String email,String password,String firsName, String lastName, String mobile) async {
  //   _profileInProgress = true;
  //   update();
  //
  //   final Map<String, dynamic> requestBody = {
  //     "firstName": firsName,
  //     "lastName": lastName,
  //     "mobile": mobile,
  //     "password" : password,
  //     "photo": "photo"
  //   };
  //
  //   final NetworkResponse response =
  //   await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
  //   _profileInProgress = false;
  //   update();
  //
  //   if (response.isSuccess) {
  //     // userData.firstName = firsName;
  //     // userData.lastName = lastName;
  //     // userData.mobile = mobile;
  //     // AuthUtility.updateUserInfo(userData);
  //     // AuthUtility.userInfo.data?.photo = photo;
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  Future<void> pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = pickedImage.path;
      final bytes = File(image).readAsBytesSync();
      base64Image = base64Encode(bytes);
      log(base64Image);
      update();
    }
  }

}
