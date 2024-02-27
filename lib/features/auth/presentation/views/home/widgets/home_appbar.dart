import 'package:flutter/material.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';

import '../../../widgets/appbar.dart';
import '../../../widgets/notification_icon.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.dark,
    this.userName,
  });

  final bool dark;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Hi, ",
                  style: Theme.of(context).textTheme.headlineLarge!.apply(color: dark ? Colors.white : CustomColors.primary),
                ),
                TextSpan(
                  text: userName,
                  style: Theme.of(context).textTheme.headlineLarge!.apply(color: CustomColors.secondary),
                ),
              ]
            ),
          ),
          Text("Let's Travel Around The World", style: Theme.of(context).textTheme.labelMedium!.apply(color: dark ? Colors.white : CustomColors.primary)),
        ],
      ),
      actions: [
        NotificationStack(onPressed: (){}, dark: dark,)
      ],
    );
  }
}