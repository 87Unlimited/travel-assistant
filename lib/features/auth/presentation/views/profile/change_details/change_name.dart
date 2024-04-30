import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/appbar.dart';
import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/validators/validation.dart';
import '../../../controllers/personalization/change_details_controllers/update_name_controller.dart';


class ChangeNameView extends StatelessWidget {
  const ChangeNameView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Change Name",
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(CustomSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change your first name and last name.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.primary),
            ),
            const SizedBox(height: CustomSizes.spaceBtwItems),

            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => Validator.validateEmptyText("First name", value),
                    expands: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: "First Name",
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => Validator.validateEmptyText("Last name", value),
                    expands: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: "Last Name",
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  Center(
                    child: SizedBox(
                      width: CustomSizes.buttonWidth,
                      height: CustomSizes.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () => controller.updateUserName(),
                        child: Center(
                          child: Text(
                            'Save',
                            style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                          ),
                        ),
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
