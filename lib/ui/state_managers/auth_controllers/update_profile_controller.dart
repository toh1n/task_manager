import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  // bool _profileUpdateInProgress = false;
  // final UserData? _userData = AuthUtility.userInfo.data;
  // String _image = _userData.photo ?? '';
  // String base64Image = '';
  //
  // bool get profileUpdateInProgress => _profileUpdateInProgress;
  // UserData get userData => _userData!; // Make sure _userData is not null before using it
  // String get image => _image;
  //
  // set imageSet(String val) {
  //   _image = val;
  // }
  //
  // Future<bool> updateProfile(
  //     String password, String firstName, String lastName, String mobile) async {
  //   _profileUpdateInProgress = true;
  //   update();
  //
  //   final Map<String, dynamic> requestBody = {
  //     "firstName": firstName,
  //     "lastName": lastName,
  //     "mobile": mobile,
  //     "password": password,
  //     "photo": base64Image
  //   };
  //
  //   final NetworkResponse response =
  //   await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
  //   _profileUpdateInProgress = false;
  //   update();
  //   if (response.isSuccess) {
  //     AuthUtility.updateUserInfo(userData);
  //     update();
  //     return true;
  //   } else {
  //     update();
  //     return false;
  //   }
  // }
  //
  // Future<void> pickImage() async {
  //   final pickedImage =
  //   await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     _image = pickedImage.path;
  //     final bytes = File(_image).readAsBytesSync();
  //     base64Image = base64Encode(bytes);
  //     log(base64Image);
  //     update();
  //   }
  // }
}
