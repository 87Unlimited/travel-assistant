import 'package:flutter/material.dart';

import '../../../../../core/util/constants/colors.dart';
import '../../../../../core/util/constants/sizes.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    super.key,
    required this.icon,
    required this.title,
    this.color = CustomColors.primary,
    required this.textStyle,
  });

  final IconData icon;
  final String title;
  final Color? color;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color,),
        const SizedBox(width: CustomSizes.textWithIconWidth,),
        Text(title, style: textStyle,),
      ],
    );
  }
}