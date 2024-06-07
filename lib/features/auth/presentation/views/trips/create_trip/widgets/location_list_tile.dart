import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';

import '../../../../../../../core/util/constants/colors.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.onPressed,
    this.icon = Iconsax.location,
  }) : super(key: key);

  final String? location;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          horizontalTitleGap: 0,
          leading: Icon(icon, color: CustomColors.primary,),
          minLeadingWidth : CustomSizes.spaceBtwItems,
          title: Align(
            alignment: const Alignment(-1, 0),
            child: Text(
              location!,
              style: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.primary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: CustomColors.whiteSmoke,
        ),
      ],
    );
  }
}
