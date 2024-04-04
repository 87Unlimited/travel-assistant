import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../core/util/constants/sizes.dart';
import '../../../../widgets/icons/text_with_icon.dart';


class LocationAndDateHeader extends StatelessWidget {
  const LocationAndDateHeader({
    super.key,
    required this.location,
    required this.dateTitle,
  });

  final String location;
  final String dateTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Location title
        TextWithIcon(
          icon: Iconsax.location,
          title: location,
          color: CustomColors.primary,
          textStyle: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: CustomColors.primary),
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),

        // Selected Date Range
        TextWithIcon(
          icon: Iconsax.calendar,
          title: dateTitle,
          color: CustomColors.primary,
          textStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(color: CustomColors.primary),
        ),
      ],
    );
  }
}