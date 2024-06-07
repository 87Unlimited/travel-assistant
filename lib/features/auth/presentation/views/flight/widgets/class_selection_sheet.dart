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
import '../../../controllers/flight/flight_controller.dart';

class ClassSelectionSheet extends StatelessWidget {
  const ClassSelectionSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                          "Select Flight Class",
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
                            leading: const Icon(Icons.airline_seat_flat, color: CustomColors.primary,),
                            title: Text(
                              'First Class',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              controller.flightClassController.text = "First Class";
                              Navigator.pop(context);
                            },
                          ),
                          // Child
                          ListTile(
                            leading: const Icon(Icons.airline_seat_recline_extra_rounded, color: CustomColors.primary,),
                            title: Text(
                              'Business Class',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              controller.flightClassController.text = "Business Class";
                              Navigator.pop(context);
                            },
                          ),
                          // Adult
                          ListTile(
                            leading: const Icon(Icons.airline_seat_recline_normal, color: CustomColors.primary,),
                            title: Text(
                              'Economy Class',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              controller.flightClassController.text = "Economy Class";
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ).toList(),
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