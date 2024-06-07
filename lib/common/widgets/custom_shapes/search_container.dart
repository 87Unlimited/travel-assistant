import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/util/constants/colors.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/device/device_utility.dart';
import '../../../../../core/util/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
      width: DeviceUtils.getScreenWidth(context),
      padding: const EdgeInsets.all(CustomSizes.md),
      decoration: BoxDecoration(
        color: showBackground ? dark ? Colors.white : Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
        border: showBorder ? Border.all(color: CustomColors.grey) : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: dark ? CustomColors.grey : CustomColors.darkGrey),
          const SizedBox(width: CustomSizes.spaceBtwItems,),
          Text("Search Destination", style: Theme.of(context).textTheme.bodySmall,),
        ],
      ),
    );
  }
}