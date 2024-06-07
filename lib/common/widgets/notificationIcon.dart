import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/util/constants/colors.dart';
import 'circular_icon_stack.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
    required this.dark,
    required this.onPressed,
    this.text = "1",
    this.iconColor,
    this.icon,
  });

  final bool dark;
  final VoidCallback onPressed;
  final Color? iconColor;
  final IconData? icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(Iconsax.notification, color: iconColor)),
        CircularIconStack(dark: dark, icon: null, text: '',),
      ],
    );
  }
}