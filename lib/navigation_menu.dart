import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/create_trip.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/home_view.dart';

import 'features/auth/presentation/views/create_trip/create_trip_detail/create_trip_detail.dart';
import 'features/auth/presentation/views/profile/profile_view.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put((NavigationController()));
    final darkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              selectedIcon: Icon(
                Iconsax.home,
                color: CustomColors.secondary,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.location),
              selectedIcon: Icon(
                Iconsax.location,
                color: CustomColors.secondary,
              ),
              label: "Location",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.calendar_edit),
              selectedIcon: Icon(
                Iconsax.calendar_edit,
                color: CustomColors.secondary,
              ),
              label: "My Trip",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_circle),
              selectedIcon: Icon(
                Iconsax.profile_circle,
                color: CustomColors.secondary,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeView(),
    Container(color: Colors.blue),
    const CreateTripView(),
    const ProfileView(),
  ];
}
