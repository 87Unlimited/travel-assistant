import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/util/constants/colors.dart';

class CircularIconStack extends StatelessWidget {
  const CircularIconStack({
    super.key,
    required this.icon,
    this.text,
    required this.dark,
    this.onTap,
  });

  final IconData? icon;
  final String? text;
  final bool dark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircleAvatar(
        backgroundColor: CustomColors.secondary,
        radius: 70,
        child: GestureDetector(
          onTap: onTap,
          child: Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}