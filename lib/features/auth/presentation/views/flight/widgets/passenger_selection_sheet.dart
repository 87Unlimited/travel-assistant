import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../../core/util/device/device_utility.dart';
import '../../../../../../common/widgets/circular_icon_stack.dart';
import '../../../../../../common/widgets/notificationIcon.dart';
import '../../../../../../core/util/helpers/helper_functions.dart';
import '../../../controllers/flight/flight_controller.dart';

class PassengerSelectionSheet extends StatelessWidget {
  const PassengerSelectionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(FlightController());

    return SingleChildScrollView(
      child: Padding(
        padding: SpacingStyle.paddingWithNormalHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: DeviceUtils.getScreenHeight(context) * .60,
              width: DeviceUtils.getScreenWidth(context),
              child: ListView(
                children: <Widget>[
                  // Title and exit button
                  Row(
                    children: [
                      Expanded(
                        // Title
                        child: Text(
                          "Passenger",
                          style: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.primary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Exit Icon
                      IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context)
                      ),
                    ],
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  // Add attractions
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: CustomColors.white,
                    ),
                    child: Wrap(
                      children: ListTile.divideTiles(
                        context: context,
                        color: CustomColors.whiteSmoke,
                        tiles: [
                          // Adult
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.person, color: CustomColors.primary,),
                            title: Text(
                              'Adult',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: FittedBox(
                              child: Row(
                                children: [
                                  CircularIconStack(
                                    dark: false,
                                    icon: Icons.add,
                                    text: '',
                                    onTap: () => controller.adultCountIncrement(),
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  Obx(() => Text(
                                    controller.adultCount.value.toString(),
                                    style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                                  ),
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  CircularIconStack(
                                    dark: false,
                                    icon: Icons.remove,
                                    text: '',
                                    onTap: () => controller.adultCountDecrement(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Child
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.child, color: CustomColors.primary,),
                            title: Text(
                              'Child',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: FittedBox(
                              child: Row(
                                children: [
                                  CircularIconStack(
                                    dark: false,
                                    icon: Icons.add,
                                    text: '',
                                    onTap: () => controller.childCountIncrement(),
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  Obx(() => Text(
                                    controller.childCount.value.toString(),
                                    style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                                  ),
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  CircularIconStack(
                                    dark: false,
                                    icon: Icons.remove,
                                    text: '',
                                    onTap: () => controller.childCountDecrement(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Adult
                          ListTile(
                            leading: const Icon(FontAwesomeIcons.baby, color: CustomColors.primary,),
                            title: Text(
                              'Baby',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: FittedBox(
                              child: Row(
                                children: [
                                  CircularIconStack(
                                    dark: false,
                                    icon: Icons.add,
                                    text: '',
                                    onTap: () => controller.babyCountIncrement(),
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  Obx(() => Text(
                                    controller.babyCount.value.toString(),
                                    style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                                  ),
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  CircularIconStack(
                                    dark: false,
                                    icon: Icons.remove,
                                    text: '',
                                    onTap: () => controller.babyCountDecrement(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  SizedBox(
                    width: CustomSizes.buttonWidth,
                    height: CustomSizes.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        String adultCount = controller.adultCount.value.toString();
                        String childCount = controller.childCount.value.toString();
                        String babyCount = controller.babyCount.value.toString();
                        controller.passengerController.text = "$adultCount Adult, $childCount Child, $babyCount Baby";
                        Navigator.pop(context);
                      } ,
                      child: const Center(
                        child: Text('Confirm'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}