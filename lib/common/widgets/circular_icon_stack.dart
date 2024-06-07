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
    this.size = 18,
  });

  final IconData? icon;
  final String? text;
  final bool dark;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: CustomColors.secondary,
        radius: 70,
        child: GestureDetector(
          onTap: onTap,
          child: Icon(
            icon,
            size: size * 0.8,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}