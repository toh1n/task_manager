import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/data/utils/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/update_profile_screen.dart';
import 'package:task_manager/ui/utils/assets_utils.dart';

class UserProfileAppBar extends StatefulWidget {
  final bool? isUpdateScreen;

  const UserProfileAppBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  String? base64Image;
  @override
  void initState() {
    super.initState();
    base64Image = AuthUtility.userInfo.data?.photo;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateProfileScreen()));
          }
        },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  Visibility(
                    visible: base64Image!.isEmpty == false,
                    replacement: ClipOval(
                        child: SvgPicture.asset(
                      AssetUtils.personSVG,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    )),
                    child: CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(base64Image!)),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
