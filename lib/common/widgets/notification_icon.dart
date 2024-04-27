import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/util/constants/colors.dart';

class NotificationStack extends StatelessWidget {
  const NotificationStack({
    super.key,
    required this.dark,
    required this.onPressed,
    this.iconColor,
  });

  final bool dark;
  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(Iconsax.notification, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: CustomColors.secondary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "2",
                style: TextStyle(color: dark ? Colors.white : Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}