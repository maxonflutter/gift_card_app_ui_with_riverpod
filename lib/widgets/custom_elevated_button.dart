import 'package:flutter/material.dart';

import '../utilities/app_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Size fixedSize;
  final Function()? onPressed;

  const CustomElevatedButton({
    required this.text,
    required this.backgroundColor,
    this.fixedSize = const Size(200, 50),
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: fixedSize,
        backgroundColor: backgroundColor,
        shape: const StadiumBorder(),
      ),
      child: AppText.medium(text, color: Colors.white),
    );
  }
}
