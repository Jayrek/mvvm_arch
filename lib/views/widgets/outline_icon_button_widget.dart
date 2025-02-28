import 'package:flutter/material.dart';

class OutlineIconButton extends StatelessWidget {
  const OutlineIconButton({
    required this.onPressed,
    required this.label,
    required this.iconData,
    super.key,
  });

  final Function()? onPressed;
  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.deepOrange,
        backgroundColor: Colors.deepOrange.shade50,
        side: const BorderSide(color: Colors.deepOrange, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
    );
  }
}
