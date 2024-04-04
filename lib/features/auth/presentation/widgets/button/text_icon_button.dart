import 'package:flutter/material.dart';

import '../../../../../core/util/constants/sizes.dart';

class TextIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? icon;
  final String buttonText;

  const TextIconButton({
    super.key,
    this.icon,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: CustomSizes.buttonWidth,
        height: CustomSizes.buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Wrap(
            children: <Widget>[
              if (icon != null) icon!,
              const SizedBox(
                width: 5,
              ),
              Text(buttonText),
            ],
          ),
        ),
      ),
    );
  }
}