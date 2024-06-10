import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/data/models/activity_model.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/activity/widgets/activity_sheet.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/details_sheet.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/google_map.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/search_direction.dart';

import '../../../../../../../common/widgets/appbar.dart';
import '../../../../../../../navigation_menu.dart';
import '../../controllers/recommendation/recommendation_controller.dart';
import '../trips/create_trip/create_trip_detail/create_trip_detail_view.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({
    super.key,
    required this.trip,
    required this.activity,
    required this.address,
    required this.controller,
  });

  final TripModel trip;
  final ActivityModel activity;
  final String address;
  final RecommendationController controller;

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavigationController());

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: false,
        leadingIcon: Iconsax.arrow_left,
        leadingOnPressed: () {
          Get.to(CreateTripDetailView(trip: trip));
        },
        // activity Name
        title: Text(
          activity.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: CustomColors.primary),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(activity.picture.toString()),
            fit: BoxFit.cover,
          ),
        ),
        // Draggable Sheet
        child: ActivitySheet(activity: activity, trip: trip, address: address, controller: controller,),
      ),
    );
  }
}