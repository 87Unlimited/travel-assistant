import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/image_strings.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_appbar.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/image_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/trips.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';
import 'package:travel_assistant/features/auth/presentation/widgets/trip/trip_cards/trip_card_create.dart';

import '../../../../../core/util/constants/shadows.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../widgets/custom_shapes/search_container.dart';
import '../../widgets/images/rounded_image.dart';
import '../../widgets/notification_icon.dart';
import '../../widgets/section_heading.dart';
import '../../widgets/trip/trip_cards/trip_card_vertical.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    const bool isTripExist = false;
    const String userName = "Chun";

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ListTile(
                title: Text.rich(
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
                    ],
                  ),
                ),
                subtitle: Text(
                  "Let's Travel Around The World",
                  style: Theme.of(context).textTheme.labelMedium!.apply(color: dark ? Colors.white : CustomColors.primary),
                ),
                trailing: NotificationStack(onPressed: (){}, dark: dark,),
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections,),

              // Search Bar
              const SearchContainer(
                text: 'Search Destination',
                showBackground: false,
                showBorder: true,
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections,),

              // Category
              const Column(
                children: [
                  // Heading
                  SectionHeading(title: "Category", showActionButton: false,),
                  SizedBox(height: CustomSizes.spaceBtwItems,),

                  // Categories
                  HomeCategories(),
                ],
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections / 2),

              // Body
              Column(
                children: [
                  const SectionHeading(title: "Top Activities", showActionButton: false,),
                  const SizedBox(height: CustomSizes.spaceBtwItems,),
                  // Activities Slider
                  const ImageSlider(banners: [CustomImages.japan, CustomImages.korea, CustomImages.thailand],),
                  const SizedBox(height: CustomSizes.spaceBtwSections,),
                  // Trip
                  SectionHeading(
                    title: "Your Trips",
                    showActionButton: isTripExist,
                    onPressed: () {
                      Get.to(const LoginView());
                    },
                  ),

                  const SizedBox(height: CustomSizes.spaceBtwItems,),

                  isTripExist
                      ? const Trips()
                      : const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TripCardCreate(),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


