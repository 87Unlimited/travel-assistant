import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/authentication/login_controller.dart';

import '../../../../core/util/constants/colors.dart';
import '../../../../core/util/constants/image_strings.dart';
import '../../../../core/util/constants/sizes.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Divider(
                  color: dark ? Colors.grey : CustomColors.textHint,
                  thickness: 0.8,
                  indent: 60,
                  endIndent: 5,
                )),
            Text(
              "Or Sign In With",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Flexible(
                child: Divider(
                  color: dark ? Colors.grey : CustomColors.textHint,
                  thickness: 0.8,
                  indent: 5,
                  endIndent: 60,
                ))
          ],
        ),
        const SizedBox(height: CustomSizes.spaceBtwSections),

        // Footer
        Column(
          children: [
            SizedBox(
              width: CustomSizes.buttonWidth,
              height: CustomSizes.buttonHeight,
              child: OutlinedButton.icon(
                onPressed: () => controller.googleSignIn(),
                icon: SvgPicture.asset(
                  CustomImages.google,
                  width: CustomSizes.iconLg,
                  height: CustomSizes.iconLg,
                ),
                label: const Text("Sign Up With Google"),
              ),
            ),
            const SizedBox(height: CustomSizes.spaceBtwItems),

            SizedBox(
              width: CustomSizes.buttonWidth,
              height: CustomSizes.buttonHeight,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  CustomImages.facebook,
                  width: CustomSizes.iconLg,
                  height: CustomSizes.iconLg,
                ),
                label: const Text("Sign Up With Facebook"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}