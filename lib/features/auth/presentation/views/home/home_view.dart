import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/image_strings.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/trips/trip_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_header.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/image_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/trips.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/trips_view.dart';

import '../../../../../auth/secrets.dart';
import '../../../../../common/widgets/notification_icon.dart';
import '../../../../../common/widgets/search_bar/location_search_bar.dart';
import '../../../../../common/widgets/section_heading.dart';
import '../../../../../common/widgets/trip/trip_cards/trip_card_create.dart';
import '../../../../../common/widgets/trip/trip_cards/trip_card_vertical.dart';
import '../../../../../core/network/network_utility.dart';
import '../../../../../core/util/constants/shadows.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../../../../navigation_menu.dart';
import '../../../data/models/autocomplete_prediction.dart';
import '../../../data/models/place_auto_complete_response.dart';
import '../../../utilities/debounce.dart';
import '../../controllers/trips/create_trip_controller.dart';
import '../trips/create_trip/widgets/location_list_tile.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<AutocompletePrediction> placePredictions = [];

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    const bool isTripExist = true;
    final tripController = Get.put(TripController());
    final searchController = Get.put(CreateTripController());
    final navController = Get.put(NavigationController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              HomeHeader(dark: dark,),
              const SizedBox(height: CustomSizes.spaceBtwSections,),

              // Search Bar
              LocationSearchBar(
                controller: searchController.location,
                leadingIcon: const Icon(Iconsax.location),
                trailingIcon: [
                  IconButton(
                    onPressed: () {},
                    icon: Center(
                      child: Icon(
                        Icons.camera_alt,
                      ),
                    ),
                  )
                ],
                hintText: "Search Country/Region",
                viewOnChanged: (value) {
                  if (value != "") {
                    searchController.placeAutoComplete(value);
                  } else {
                    searchController.placePredictions.clear();
                  }
                },
                suggestionsBuilder: (BuildContext context, SearchController location) {
                  return Iterable<Widget>.generate(
                      placePredictions.length, (int index) {
                    return LocationListTile(
                      location: placePredictions[index].description,
                      onPressed: () {

                      },
                    );
                  });
                },
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
              const SectionHeading(title: "Top Activities"),
              const SizedBox(height: CustomSizes.spaceBtwItems,),

              // Activities Slider
              const ImageSlider(banners: [CustomImages.japan, CustomImages.korea, CustomImages.thailand],),
              const SizedBox(height: CustomSizes.spaceBtwSections,),

              // Your Trips
              SectionHeading(
                title: "Your Trips",
                showActionButton: tripController.homeViewTrips.isNotEmpty,
                onPressed: () => navController.selectedIndex.value = 2
              ),

              const SizedBox(height: CustomSizes.spaceBtwItems,),

              Obx(() {
                if (tripController.homeViewTrips.isEmpty) {
                  return TripCardCreate();
                }
                return SizedBox(
                  height: 210,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tripController.homeViewTrips.length,
                    itemBuilder: (_, index) =>
                        TripCard(trip: tripController.homeViewTrips[index]),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}


