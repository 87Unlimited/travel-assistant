import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/image_strings.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/trips/trip_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/flight/widgets/flight_card_oneway.dart';
import 'package:travel_assistant/features/auth/presentation/views/flight/widgets/flight_card_roundtrip.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_header.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/image_slider.dart';

import '../../../../../common/widgets/section_heading.dart';
import '../../../../../common/widgets/trip/trip_cards/trip_card_create.dart';
import '../../../../../common/widgets/trip/trip_cards/trip_card_vertical.dart';
import '../../../../../core/util/constants/colors.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../../../../navigation_menu.dart';
import '../../../data/models/autocomplete_prediction.dart';
import '../../../data/models/place_auto_complete_response.dart';
import '../../../domain/services/flight_services.dart';
import '../../../domain/services/location_services.dart';
import '../flight/flight_view.dart';
import '../trips/create_trip/create_trip_view.dart';

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
    final locationServices = Get.put(LocationServices());
    final navController = Get.put(NavigationController());
    final flightServices = Get.put(FlightServices());

    tripController.fetchHomeViewTrips();
    tripController.fetchHomeViewFlights();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              HomeHeader(dark: dark,),
              const SizedBox(height: CustomSizes.spaceBtwSections,),

              // Search Bar
              // LocationSearchBar(
              //   controller: locationServices.location,
              //   leadingIcon: const Icon(Iconsax.location),
              //   trailingIcon: [
              //     IconButton(
              //       onPressed: () {},
              //       icon: Center(
              //         child: Icon(
              //           Icons.camera_alt,
              //         ),
              //       ),
              //     )
              //   ],
              //   hintText: "Search Country/Region",
              //   viewOnChanged: (value) {
              //     if (value != "") {
              //       locationServices.placeAutoComplete(value, "country");
              //     } else {
              //       locationServices.placePredictions.clear();
              //     }
              //   },
              //   suggestionsBuilder: (BuildContext context, SearchController location) {
              //     return Iterable<Widget>.generate(
              //         placePredictions.length, (int index) {
              //       return LocationListTile(
              //         location: placePredictions[index].description,
              //         onPressed: () {
              //
              //         },
              //       );
              //     });
              //   },
              // ),
              SizedBox(
                width: CustomSizes.buttonWidth,
                height: CustomSizes.buttonHeight,
                child: ElevatedButton(
                  onPressed: () => flightServices.fetchAirport(-37.84, -46.11),
                  child: const Center(
                    child: Text('Testing Button'),
                  ),
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections,),

              tripController.upcomingFlights.length >= 0 ? SizedBox(
                child: (tripController.upcomingFlights != FlightModel.empty()) ? Column(
                  children: [
                    const SectionHeading(title: "Upcoming Bookings"),
                    const SizedBox(height: CustomSizes.spaceBtwItems,),

                    Obx(() { return tripController.isLoading.value ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          const SizedBox(height: CustomSizes.spaceBtwItems),
                          Text(
                            "Loading...",
                            style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.darkGrey),
                          ),
                        ],
                      ),
                    ) : SizedBox(
                        height: 300,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tripController.upcomingFlights.length,
                            itemBuilder: (_, index) => FlightCardRoundTrip(flight: tripController.upcomingFlights[index]),
                          ),
                        );
                    }),
                    const SizedBox(height: CustomSizes.spaceBtwSections,),
                  ],
                ) : SizedBox(),
              ) : SizedBox(),

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

              // FlightCard(flight: flight),
              // const SizedBox(height: CustomSizes.spaceBtwItems,),

              // Activities Slider
              // const ImageSlider(banners: [CustomImages.japan, CustomImages.korea, CustomImages.thailand],),
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


