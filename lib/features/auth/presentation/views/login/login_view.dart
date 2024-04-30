import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:local_auth/local_auth.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/constants/spacing_styles.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/authentication/login_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/widgets/login_form.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/widgets/login_header.dart';
import 'package:travel_assistant/navigation_menu.dart';

import '../../../../../common/widgets/social_button.dart';
import '../../../../../common/widgets/text/signup_signin_text_switch.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: SpacingStyle.loginPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const LoginHeader(title: "Sign In To Continue",),
                const SizedBox(height: CustomSizes.spaceBtwSections),

                // Login form
                LoginForm(),
                const SizedBox(height: CustomSizes.spaceBtwSections),

                // Register Button
                SignupSignInTextSwitch(registered: false,),
                const SizedBox(height: CustomSizes.spaceBtwItems),

                // Sign in with google of facebook
                SocialButton(dark: dark),
              ],
            )),
      ),
    );
  }
}