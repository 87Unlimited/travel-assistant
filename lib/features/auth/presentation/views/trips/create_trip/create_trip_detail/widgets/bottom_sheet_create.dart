import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../../core/util/device/device_utility.dart';

class BottomSheetCreate extends StatelessWidget {
  const BottomSheetCreate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                          "Add Location",
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
                      color: CustomColors.whiteSmoke,
                    ),
                    child: Wrap(
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          // Title
                          ListTile(
                            leading: const Icon(Iconsax.search_normal, color: CustomColors.primary,),
                            title: Text(
                              'Search Attractions',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {

                            },
                          ),
                          // Title
                          ListTile(
                            leading: const Icon(Icons.add, color: CustomColors.primary,),
                            title: Text(
                              'Add Custom Attractions',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  // Add Flight and hotel
                  Text(
                    "Add Flight and hotel",
                    style: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.primary),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: CustomColors.whiteSmoke,
                    ),
                    child: Wrap(
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          // Title
                          ListTile(
                            leading: const Icon(Iconsax.building, color: CustomColors.primary,),
                            title: Text(
                              'Add Hotel',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Title
                          ListTile(
                            leading: const Icon(CupertinoIcons.airplane, color: CustomColors.primary,),
                            title: Text(
                              'Add Flight',
                              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ).toList(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}