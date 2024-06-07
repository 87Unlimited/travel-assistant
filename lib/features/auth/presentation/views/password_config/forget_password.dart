import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/common/widgets/appbar.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/authentication/forget_password_controller.dart';

import '../../../../../core/util/constants/image_strings.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../../../../core/util/validators/validation.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CustomSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headings
              Text(
                "Forget Password",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              Text(
                "Enter the email address of your account.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections * 2),

              // Email
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: (value) => Validator.validateEmail(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                    labelText: "Email",
                  ),
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  child: const Text("Continue"),
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
