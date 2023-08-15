import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/ui/state_managers/update_profile_controller.dart';
import 'package:task_manager/ui/widgets/my_button.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData = AuthUtility.userInfo.data!;
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTEController.text = userData.email ?? '';
    _firstNameTEController.text = userData.firstName ?? '';
    _lastNameTEController.text = userData.lastName ?? '';
    _mobileTEController.text = userData.mobile ?? '';
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
                const UserProfileAppBar(
                  isUpdateScreen: true,
                ),
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
                  child: GetBuilder<UpdateProfileController>(
                      builder: (updateProfileController) {
                    return Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4, color: Colors.black12),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Visibility(
                                    visible: updateProfileController.image.isEmpty,
                                    replacement: Image(
                                        image: FileImage(
                                          File(updateProfileController.image),
                                        ),
                                        fit: BoxFit.cover),
                                    child: const Image(
                                      image: NetworkImage(
                                          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1331&q=80"),
                                      fit: BoxFit.cover,
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
                                      updateProfileController.pickImage();
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                ),
                              )
                            ],
                          ),
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
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your email';
                            }
                            return null;
                          },
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
                            visible: false,
                            voidCallback: () {
                              // if (_formKey.currentState!.validate()) {
                              //   updateProfileController
                              //       .updateProfile(
                              //           _emailTEController.text.trim(),
                              //           _passwordTEController.text,
                              //           _firstNameTEController.text.trim(),
                              //           _lastNameTEController.text.trim(),
                              //           _mobileTEController.text.trim())
                              //       .then((value) {
                              //     if (value) {
                              //       Get.snackbar("Success",
                              //           "Profile Updated Successfully");
                              //       Get.offAll(const BottomNavBaseScreen());
                              //     } else {
                              //       Get.snackbar(
                              //           "Failed", "Failed to update profile");
                              //     }
                              //   });
                              // }
                            })
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
