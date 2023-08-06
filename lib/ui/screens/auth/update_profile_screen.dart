import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailTEController = TextEditingController();
  TextEditingController firstNameTEController = TextEditingController();
  TextEditingController lastNameTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();
  TextEditingController profilePictureTEController = TextEditingController();
  TextEditingController phoneNumberTEController = TextEditingController();

  File? _pimage;

  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    userData();
  }

  Future<void> userData() async {
    emailTEController.text = AuthUtility.userInfo.data!.email!;
    firstNameTEController.text = AuthUtility.userInfo.data!.firstName!;
    lastNameTEController.text = AuthUtility.userInfo.data!.lastName!;
    phoneNumberTEController.text = AuthUtility.userInfo.data!.mobile!;
  }

  Future<void> updateProfile()async {
    isLoading = true;
    if(mounted){
      setState(() {});
    }

    Map<String, dynamic> body = {
      "email":emailTEController.text.trim(),
      "firstName":firstNameTEController.text.trim(),
      "lastName":lastNameTEController.text.trim(),
      "mobile":phoneNumberTEController.text.trim(),
      "photo":_pimage.toString(),
    };

    NetworkResponse response = await NetworkCaller().postRequest(Urls.profileUpdate, body);

    isLoading = false;
    if(mounted){
      setState(() {});
    }

    if(response.isSuccess){
      log(_pimage.toString());
      log(response.statusCode.toString());
    }else{
      log(response.statusCode.toString());
    }

}

  Future imagePick() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null){
      return;
    }
    final imgTemp = File(image.path);
    setState(() {
      _pimage=imgTemp;
      log(imgTemp.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Material(child: UserProfileBanner()),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Text(
                        "Update Profile",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.blueAccent,
                                child: ClipOval(
                                  child: _pimage!=null ? Image.file(_pimage!,
                                    fit: BoxFit.cover,
                                    width: 200.0,
                                    height: 200.0,
                                  ): Image.network('https://t4.ftcdn.net/jpg/01/86/29/31/360_F_186293166_P4yk3uXQBDapbDFlR17ivpM6B1ux0fHG.jpg'),

                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 210,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 30.0),
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: IconButton(
                                        onPressed: () {
                                          imagePick();
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ))),
                              ),
                              Spacer(
                                flex: 20,
                              ),
                            ],
                          ),
                        ],
                      ),

                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     prefixIcon: TextButton(
                      //       style: TextButton.styleFrom(
                      //         backgroundColor: Colors.teal,
                      //         foregroundColor: Colors.white,
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(5.0),
                      //             bottomLeft: Radius.circular(5.0),
                      //           ),
                      //         ),
                      //       ),
                      //       onPressed: () async {
                      //         await imagePick();
                      //       },
                      //       child: const Text('Photos'),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 12,
                      ),


                      TextField(
                        controller: emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: phoneNumberTEController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Mobile Number",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: passwordTEController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: isLoading == false,
                          replacement: Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                              onPressed: () {
                                updateProfile();
                              },
                              child: const Text("Update Profile", style: TextStyle(fontSize: 16),)),
                        ),
                      ),

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