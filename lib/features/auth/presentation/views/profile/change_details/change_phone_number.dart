import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/appbar.dart';
import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/validators/validation.dart';
import '../../../controllers/personalization/change_details_controllers/update_phone_number_controller.dart';

class ChangePhoneNumberView extends StatelessWidget {
  const ChangePhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Change Phone Number",
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
              "Enter your new phone number here.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: CustomColors.primary),
            ),
            const SizedBox(height: CustomSizes.spaceBtwItems),

            Form(
              key: controller.updatePhoneNumberFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: (value) => Validator.validatePhoneNumber(value),
                    expands: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: "Phone Number",
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  Center(
                    child: SizedBox(
                      width: CustomSizes.buttonWidth,
                      height: CustomSizes.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () => controller.updatePhoneNumber(),
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
