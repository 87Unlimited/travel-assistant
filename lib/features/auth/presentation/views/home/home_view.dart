import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/widgets/appbar.dart';

import '../../../../../core/util/helpers/helper_functions.dart';
import '../../widgets/notification_icon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                CustomAppBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome", style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.grey)),
                      Text("Welcome", style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.black12)),
                    ],
                  ),
                  actions: [
                    NotificationStack(onPressed: (){}, dark: dark,)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
