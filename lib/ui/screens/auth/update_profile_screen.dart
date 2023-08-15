import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/update_profile_controller.dart';
import 'package:task_manager/ui/utils/assets_utils.dart';
import 'package:task_manager/ui/widgets/my_button.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _image = '';
  final UserData _userData = AuthUtility.userInfo.data!;
  final UpdateProfileController _updateProfileController = Get.find<UpdateProfileController>();



  @override
  void initState() {
    super.initState();
    _emailTEController.text = _userData.email ?? '';
    _firstNameTEController.text = _userData.firstName ?? '';
    _lastNameTEController.text = _userData.lastName ?? '';
    _mobileTEController.text = _userData.mobile ?? '';
    _image = _userData.photo ?? '';
    _updateProfileController.imageSet(_image);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileAppBar(isUpdateScreen: true,),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GetBuilder<UpdateProfileController>(
                        builder: (context) {
                          return Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 4, color: Colors.black12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Visibility(
                                      visible: _updateProfileController.image.isEmpty == false,
                                      replacement: SvgPicture.asset(AssetUtils.personSVG,fit: BoxFit.cover,),
                                      child: Image.memory(
                                        base64Decode(_updateProfileController.image),
                                        fit: BoxFit.cover,
                                        width: 130,
                                        height: 130,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.red,
                                      ),
                                      color: Colors.blue,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _updateProfileController.pickImage();
                                      },
                                      child: const Icon(Icons.edit),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) ||
                              value!.length < 11) {
                            return 'Enter your valid mobile no';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) ||
                              value!.length <= 5) {
                            return 'Enter a password more than 6 letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyButton(
                          visible: _updateProfileController.profileUpdateInProgress,
                          voidCallback: () {
                            if (_formKey.currentState!.validate()) {
                              _updateProfileController.updateProfile(_firstNameTEController.text, _lastNameTEController.text, _mobileTEController.text, _passwordTEController.text,_emailTEController.text).then((value){
                                if(value){
                                  Get.snackbar("Success", "message");
                                  Get.offAll(const BottomNavBaseScreen());
                                }else{
                                  Get.snackbar("Failed", "message");
                                }
                              });
                              setState(() {});
                              // _updateProfileController
                              //     .updateProfile(
                              //         _passwordTEController.text,
                              //         _firstNameTEController.text,
                              //         _lastNameTEController.text,
                              //         _mobileTEController.text)
                              //     .then((value) {
                              //   if (value) {
                              //     Get.snackbar("Success",
                              //         "Profile Updated Successfully");
                              //     Get.offAll(const BottomNavBaseScreen());
                              //   } else {
                              //     Get.snackbar(
                              //         "Failed", "Failed to update profile");
                              //   }
                              // });
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
