import 'package:flutter/material.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_appbar.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_categories.dart';

import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../widgets/custom_shapes/search_container.dart';
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
              ],
            ),

            // Body

          ],
        ),
      ),
    );
  }
}
