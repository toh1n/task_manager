import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/update_profile_screen.dart';

class UserProfileBanner extends StatelessWidget {
   const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.green,
      leading: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>  UpdateProfileScreen()));
        },
        child:  CircleAvatar(
          backgroundImage: NetworkImage(
            'https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=',
          ),
          radius: 15,
        ),
      ),
      title:  Text(
        AuthUtility.userInfo.data?.firstName ?? '',
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      subtitle:  Text(
        AuthUtility.userInfo.data?.email ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      trailing: IconButton(onPressed: (){
        AuthUtility.clearUserInfo();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()),(route) => false,);
      }, icon: const Icon(Icons.login_outlined)),
    );
  }
}
