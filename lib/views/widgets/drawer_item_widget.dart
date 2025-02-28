import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    required this.iconData,
    required this.label,
    required this.onTap,
    super.key,
  });
  final IconData? iconData;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconData != null ? Icon(iconData) : null,
      title: Text(label),
      onTap: () {
        Navigator.of(context).pop();
        onTap;
      },
    );
  }
}
