import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/validators/validation.dart';

import '../../../../../../core/util/constants/sizes.dart';
import '../../../controllers/login_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
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

          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => Validator.validateEmptyText("Password", value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.lock),
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                ),
              ),
            ),
          ),

          // Remember Me & Forget Password
          Row(
            children: [
              // Remember Me
              Expanded(
                child: Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                    const Text("Remember Me"),
                  ],
                ),
              ),

              // Forget Password
              TextButton(
                  onPressed: () {
                    // Get.to();
                  },
                  child: Text(
                    "Forget password?",
                    style: Theme.of(context).textTheme.labelMedium,
                  )
              ),
            ],
          ),
          const SizedBox(height: CustomSizes.spaceBtwSections),

          // Login Button
          Center(
            child: SizedBox(
              width: CustomSizes.buttonWidth,
              height: CustomSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Center(
                  child: Text('Login'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
