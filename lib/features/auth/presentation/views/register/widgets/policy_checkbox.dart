import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../controllers/signup_controller.dart';

class PolicyCheckbox extends StatelessWidget {
  const PolicyCheckbox({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value))),
        const SizedBox(width: CustomSizes.spaceBtwItems / 2),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "I agree to ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: "Privacy Policy ",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? Colors.white : CustomColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? Colors.white : CustomColors.primary,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Go to Privacy Policy page.
                  // Get.to();
                },
            ),
            TextSpan(
              text: "and ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: "Terms of use ",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? Colors.white : CustomColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? Colors.white : CustomColors.primary,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Go to Terms of use page.
                  // Get.to();
                },
            ),
          ]),
        ),
      ],
    );
  }
}