import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';

import '../../../../../../common/widgets/appbar.dart';
import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/validators/validation.dart';
import '../../../controllers/personalization/change_details_controllers/update_name_controller.dart';


class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Re-Authenticate User",
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
              key: controller.reAuthFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: (value) => Validator.validateEmail(value),
                    expands: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.mail),
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwItems),

                  // Password
                  Obx(
                        () => TextFormField(
                      controller: controller.verifyPassword,
                      validator: (value) => Validator.validatePassword(value),
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(CupertinoIcons.lock),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                          onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  Center(
                    child: SizedBox(
                      width: CustomSizes.buttonWidth,
                      height: CustomSizes.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () => controller.reAuthenticateEmailAndPasswordUser(),
                        child: Center(
                          child: Text(
                            'Verify',
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
