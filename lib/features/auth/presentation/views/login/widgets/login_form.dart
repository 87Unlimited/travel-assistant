import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: controller.email,
            decoration: const InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
              labelText: "Email",
            ),
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),
          // Password
          TextFormField(
            controller: controller.password,
            decoration: InputDecoration(
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              labelText: "Password",
              suffixIcon: IconButton(
                icon: const Icon(FontAwesomeIcons.solidEyeSlash),
                onPressed: () {
                },
              ),
            ),
            obscureText: true,
          ),

          // Remember Me & Forget Password
          Row(
            children: [
              // Remember Me
              Expanded(
                child: Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
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
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
