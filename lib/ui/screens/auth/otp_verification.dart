import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otp = TextEditingController();


  @override
  void initState(){
    super.initState();
  }

  bool _verifyInProgress = false;

  Future<void> verifyEmail() async {
    _verifyInProgress = true;
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String email = sharedPrefs.getString('email')!;
    log(email);
    log(otp.text);

    if (mounted) {
      setState(() {});
    }
    String otpUrl = "${Urls.resetPassOTP}$email/${otp.text.trim()}";
    final NetworkResponse response = await NetworkCaller()
        .verifyEmailRequest(otpUrl);
    _verifyInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      await AuthUtility.saveString('otp',otp.text);
      otp.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Success')));
        Navigator.push(context, MaterialPageRoute(builder: (_)=> const ResetPasswordScreen()));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect OTP')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Text(
                  'PIN Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'A 6 digits pin will sent to your email address',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter OTP',
                  ),
                  controller: otp,
                ),
                // PinCodeTextField(
                //   length: 6,
                //   obscureText: false,
                //   animationType: AnimationType.fade,
                //   keyboardType: TextInputType.number,
                //   pinTheme: PinTheme(
                //     shape: PinCodeFieldShape.box,
                //     borderRadius: BorderRadius.circular(5),
                //     fieldHeight: 50,
                //     fieldWidth: 40,
                //     inactiveFillColor: Colors.white,
                //     inactiveColor: Colors.red,
                //     activeColor: Colors.white,
                //     selectedColor: Colors.green,
                //     selectedFillColor: Colors.white,
                //     activeFillColor: Colors.white,
                //   ),
                //   animationDuration: const Duration(milliseconds: 300),
                //   enableActiveFill: true,
                //   cursorColor: Colors.green,
                //   enablePinAutofill: true,
                //   onCompleted: (v) {},
                //   onChanged: (value) {},
                //   beforeTextPaste: (text) {
                //     // print("Allowing to paste $text");
                //     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //     //but you can show anything you want here, like your pop up saying wrong paste format or etc
                //     return true;
                //   },
                //   appContext: context,
                // ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _verifyInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: ()  {
                        verifyEmail();

                      },
                      child: const Text('Verify'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                                  (route) => false);
                        },
                        child: const Text('Sign in')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}