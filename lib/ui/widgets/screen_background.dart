import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/utils/assets_utils.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,

          child: SvgPicture.asset(AssetUtils.backgroundSVG,fit: BoxFit.cover,),
        ),
        SafeArea(child: child),
      ],

    );
  }
}
