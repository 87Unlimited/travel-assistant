import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../core/util/constants/image_strings.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../controllers/authentication/forget_password_controller.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});

  final String email;

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
            children: [
              Image(
                image: const AssetImage(CustomImages.deliveredEmailIllustration),
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Email, Title and subtitle
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              Text(
                "Reset Password Email Sent",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              Text(
                "Check Your Email To Reset Password.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginView()),
                  child: const Text("Done"),
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // Resend email
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                  child: Text("Resend Email"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
