import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';

class ProfileTextButton extends StatelessWidget {
  const ProfileTextButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CustomSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,),),
            Expanded(flex: 5, child: Text(value, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis,),),
            const Expanded(child: Icon(Iconsax.arrow_right_34, size: 18,)),
          ],
        ),
      ),
    );
  }
}