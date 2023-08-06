import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/services/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/auth/otp_verification.dart';
import 'package:task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  TextEditingController emailTEController = TextEditingController();
  bool _verifyInProgress = false;

  Future<void> verifyEmail() async {
    _verifyInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .verifyEmailRequest("${Urls.verifyEmail}${emailTEController.text.trim()}");
    _verifyInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      await AuthUtility.saveString('email',emailTEController.text);
      emailTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Code Sent')));
        Navigator.push(context, MaterialPageRoute(builder: (_)=> const OtpVerificationScreen()));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect email or password')));
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
                const SizedBox(height: 64,),
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4,),
                Text(
                  'A 6 digits pin will be sent to your email address',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  controller: emailTEController,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _verifyInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: () {
                        verifyEmail();
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
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
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text('Sign in')),
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