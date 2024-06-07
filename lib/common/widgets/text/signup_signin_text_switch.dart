import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/views/register/register_view.dart';

import '../../../../../core/util/constants/colors.dart';
import '../../../features/auth/presentation/views/login/login_view.dart';

class SignupSignInTextSwitch extends StatelessWidget {
  final bool registered;

  const SignupSignInTextSwitch({
    super.key,
    required this.registered,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: registered ? "Already registered? " : "Not registered yet? ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: registered ? "Login here! " : "Register here! ",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: CustomColors.secondary,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                Get.to(registered ? LoginView() : RegisterView());
              },
            ),
          ],
        ),
      ),
    );
  }
}