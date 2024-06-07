import 'package:flutter/material.dart';

class TripCardTitleText extends StatelessWidget {
  const TripCardTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
    required this.textStyle,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
