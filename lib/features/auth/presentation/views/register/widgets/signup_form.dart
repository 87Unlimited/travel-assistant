import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/domain/controllers/signup_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/register/widgets/policy_checkbox.dart';

import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/validators/validation.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(CupertinoIcons.mail),
              labelText: "Email",
            ),
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => Validator.validateEmptyText("First name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "First Name",
                  ),
                ),
              ),
              const SizedBox(width: CustomSizes.spaceBtwItems),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => Validator.validateEmptyText("Last name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Last Name",
                  ),
                ),)
            ],
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // User Name
          TextFormField(
            controller: controller.userName,
            validator: (value) => Validator.validateEmptyText("User Name", value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user_edit),
              labelText: "User Name",
            ),
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => Validator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(CupertinoIcons.phone),
              labelText: "Phone Number",
            ),
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
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
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Terms of use checkbox
          PolicyCheckbox(dark: dark),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Sign Up Button
          Center(
            child: SizedBox(
              width: CustomSizes.buttonWidth,
              height: CustomSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Center(
                  child: Text('Create Account'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}