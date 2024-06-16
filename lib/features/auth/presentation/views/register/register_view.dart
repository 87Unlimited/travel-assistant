import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import 'package:travel_assistant/features/auth/presentation/views/register/widgets/signup_form.dart';

import '../../../../../common/widgets/social_button.dart';
import '../../../../../common/widgets/text/signup_signin_text_switch.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../login/widgets/login_header.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  // Future<void> createUser(UserModel user) async {
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginHeader(title: "Sign Up To Continue",),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Personal Details
              SignupForm(dark: dark,),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Login page
              SignupSignInTextSwitch(registered: true,),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Sign in with google of facebook
              SocialButton(dark: dark),
            ],
          ),
        ),
      ),
    );
  }
}




