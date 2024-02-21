import 'package:flutter/material.dart';

import '../../../../../../core/util/constants/sizes.dart';

class LoginHeader extends StatelessWidget {
  final String title;

  const LoginHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back!",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
