import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/image_strings.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_appbar.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/home_categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/image_slider.dart';
import 'package:travel_assistant/features/auth/presentation/views/home/widgets/trips.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../auth/secrets.dart';
import '../../../../../common/widgets/notification_icon.dart';
import '../../../../../common/widgets/search_bar/location_search_bar.dart';
import '../../../../../common/widgets/section_heading.dart';
import '../../../../../common/widgets/trip/trip_cards/trip_card_create.dart';
import '../../../../../core/network/network_utility.dart';
import '../../../../../core/util/constants/shadows.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../core/util/helpers/helper_functions.dart';
import '../../../data/models/autocomplete_prediction.dart';
import '../../../data/models/place_auto_complete_response.dart';
import '../../../utilities/debounce.dart';
import '../create_trip/widgets/location_list_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final SearchController _location;
  List<AutocompletePrediction> placePredictions = [];
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    _location = SearchController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _location.dispose();
  }

  void placeAutoComplete(String query) async {
    _debouncer.run(() {
      Uri uri = Uri.https("maps.googleapis.com",
          'maps/api/place/autocomplete/json',
          {
            "input": query!,
            "key": placesApiKey,
            "types": "country",
          });

      NetworkUtility.fetchUrl(uri).then((String? response) {
        if (response != null) {
          PlaceAutoCompleteResponse result = PlaceAutoCompleteResponse
              .parseAutoCompleteResult(response);
          if (result.predictions != null) {
            setState(() {
              placePredictions = result.predictions!;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    const bool isTripExist = true;
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
              LocationSearchBar(
                controller: _location,
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
                    placeAutoComplete(value);
                  } else {
                    placePredictions.clear();
                    setState(() {});
                  }
                },
                suggestionsBuilder: (BuildContext context, SearchController location) {
                  return Iterable<Widget>.generate(
                      placePredictions.length, (int index) {
                    return LocationListTile(
                      location: placePredictions[index].description,
                      press: () {

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
              Column(
                children: [
                  const SectionHeading(title: "Top Activities"),
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


