import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  String _image = '';
  bool _profileUpdateInProgress = false;
  bool get profileUpdateInProgress => _profileUpdateInProgress;
  void imageSet(String value) {
    _image = value;
  }

  String get image => _image;

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = pickedImage.path;
      final bytes = File(_image).readAsBytesSync();
      _image = base64Encode(bytes);
      update();
    }
  }

  Future<bool> updateProfile(String firstName, String lastName, String mobile,
      String password, String email) async {
    _profileUpdateInProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": _image
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
    _profileUpdateInProgress = false;
    update();
    if (response.isSuccess) {
      requestBody['email'] = email;
      AuthUtility.updateUserInfo(UserData.fromJson(requestBody));
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
