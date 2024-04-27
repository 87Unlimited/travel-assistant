import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = CustomSizes.lg,
    this.color,
    this.backgroundColor,
    this.onPressed,
    required this.icon,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : HelperFunctions.isDarkMode(context)
            ? Colors.black.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: (){}, icon: Icon(icon, color: color, size: size,),),
    );
  }
}