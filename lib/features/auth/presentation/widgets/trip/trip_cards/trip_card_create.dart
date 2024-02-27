import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/helpers/helper_functions.dart';
import '../../../../../../navigation_menu.dart';
import '../../../views/create_trip/create_trip.dart';
import '../../custom_shapes/rounded_container.dart';

class TripCardCreate extends StatelessWidget {
  const TripCardCreate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.find<NavigationController>();

    return GestureDetector(
      onTap: (){
        controller.selectedIndex.value = 2;
      },
      child: Padding(
        padding: const EdgeInsets.only(right: CustomSizes.spaceBtwItems),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
            color: dark ? CustomColors.darkGrey : Colors.white,
          ),
          child: Column(
            children: [
              RoundedContainer(
                height: 200,
                padding: const EdgeInsets.all(CustomSizes.sm),
                backgroundColor: dark ? CustomColors.darkGrey : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Stack(
                      children: [
                        // Image
                        RoundedContainer(height: 130, padding: EdgeInsets.all(CustomSizes.sm), backgroundColor: CustomColors.whiteSmoke,),
                        // Favourite Icon Button
                        Positioned(
                          left: 55,
                          top: 25,
                          child: Icon(Iconsax.additem5, color: CustomColors.secondary, size: 70,),
                        )
                      ],
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 2,),
                    // Title
                    Text(
                      "Create Trip",
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.primary),
                    ),
                    // Text
                    Text(
                      "Create stories of your own.",
                      style: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}