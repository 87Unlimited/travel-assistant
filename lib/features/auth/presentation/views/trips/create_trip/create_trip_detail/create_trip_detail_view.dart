import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/details_sheet.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/google_map.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/search_direction.dart';

import '../../../../../../../common/widgets/appbar.dart';
import '../../../../../../../navigation_menu.dart';
import '../../../../../data/models/flight_model.dart';
import '../create_trip_view.dart';

class CreateTripDetailView extends StatelessWidget {
  const CreateTripDetailView({
    super.key,
    required this.trip,
    this.flight,
  });

  final TripModel trip;
  final FlightModel? flight;

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavigationController());

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: false,
        leadingIcon: Iconsax.arrow_left,
        leadingOnPressed: () {
          navController.selectedIndex.value = 2;
          Get.to(NavigationMenu());
        },
        actions: [
          IconButton(
            onPressed: () => Get.to(CreateTripView(trip: trip)),
            icon: Icon(Iconsax.edit),
          ),
        ],

        // Trip Name
        title: Text(
          trip.tripName,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: CustomColors.primary),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              GoogleMapWidget(trip: trip),
            ],
          ),
          // Draggable Sheet
          DetailsSheet(trip: trip),
        ],
      ),
    );
  }
}