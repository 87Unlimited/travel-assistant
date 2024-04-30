import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';

import '../../../../../../common/widgets/appbar.dart';
import '../../../../../../common/widgets/notification_icon.dart';
import '../../../../../../common/widgets/shimmer_effect/shimmer_effect.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Obx(() {
      if (controller.profileLoading.value) {
        return const ShimmerEffect(width: 80, height: 15);
      }
      return ListTile(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Hi, ",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .apply(color: dark ? Colors.white : CustomColors.primary),
              ),
              TextSpan(
                text: controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .apply(color: CustomColors.secondary),
              ),
            ],
          ),
        ),
        subtitle: Text(
          "Let's Travel Around The World",
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: dark ? Colors.white : CustomColors.primary),
        ),
        trailing: NotificationStack(
          onPressed: () {},
          dark: dark,
        ),
      );
    });
  }
}