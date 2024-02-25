import 'package:flutter/material.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/image_strings.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_appbar.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/image_slider.dart';

import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../widgets/custom_shapes/search_container.dart';
import '../../widgets/images/rounded_image.dart';
import '../../widgets/section_heading.dart';

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
                // Appbar
                HomeAppBar(dark: dark, userName: "Chun",),
                const SizedBox(height: CustomSizes.spaceBtwSections,),

                // Search Bar
                const SearchContainer(
                  text: 'Search Destination',
                  showBackground: false,
                  showBorder: true,
                ),
                const SizedBox(height: CustomSizes.spaceBtwSections,),

                // Category
                const Padding(
                  padding: EdgeInsets.only(left: CustomSizes.defaultSpace),
                  child: Column(
                    children: [
                      // Heading
                      SectionHeading(title: "Category", showActionButton: false,),
                      SizedBox(height: CustomSizes.spaceBtwItems,),

                      // Categories
                      HomeCategories(),
                    ],
                  ),
                ),
                const SizedBox(height: CustomSizes.spaceBtwSections,),
              ],
            ),

            // Body
            const Padding(
              padding: EdgeInsets.all(CustomSizes.defaultSpace),
              child: Column(
                children: [
                  SectionHeading(title: "Top Activities", showActionButton: false,),
                  SizedBox(height: CustomSizes.spaceBtwItems,),
                  // Activities Slider
                  ImageSlider(banners: [CustomImages.japan, CustomImages.korea, CustomImages.thailand],),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
