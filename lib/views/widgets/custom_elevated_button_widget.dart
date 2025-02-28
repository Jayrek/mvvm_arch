import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        child: child);
  }
}
