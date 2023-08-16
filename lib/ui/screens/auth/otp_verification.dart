import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager/ui/state_managers/auth_controllers/otp_verify_controller.dart';
import 'package:task_manager/ui/widgets/my_button.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                GetBuilder<OtpVerifyController>(builder: (otpVerifyController) {
                  return Column(
                    children: [
                      PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveFillColor: Colors.grey,
                            activeColor: Colors.green),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: _otpTEController,
                        onCompleted: (value) {
                          otpVerifyController
                              .verifyOtp(_otpTEController.text.trim())
                              .then((value) {
                            if (value) {
                              Get.snackbar("Success", "OTP Verified");
                              Get.to(const ResetPasswordScreen());
                            } else {
                              Get.snackbar("Failed", "Wrong OTP");
                            }
                          });
                        },
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        appContext: context,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyButton(
                          visible: otpVerifyController.verifyInProgress,
                          voidCallback: () {
                            otpVerifyController
                                .verifyOtp(_otpTEController.text.trim())
                                .then((value) {
                              if (value) {
                                Get.snackbar("Success", "OTP Verified");
                                Get.to(const ResetPasswordScreen());
                              } else {
                                Get.snackbar("Failed", "Wrong OTP");
                              }
                            });
                          }),
                    ],
                  );
                }),
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
