import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final bool visible;
  final VoidCallback voidCallback;
  const MyButton({super.key,required this.visible,required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Visibility(
        visible: visible == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ElevatedButton(
            onPressed: voidCallback,
            child: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
