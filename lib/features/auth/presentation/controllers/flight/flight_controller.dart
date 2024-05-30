import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/util/device/device_utility.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/trip/trip_repository.dart';
import '../../views/flight/widgets/passenger_selection_sheet.dart';
import '../../views/trips/create_trip/create_trip_detail/widgets/create_attraction_selection_sheet.dart';


class FlightController extends GetxController {
  static FlightController get instance => Get.find();

  GlobalKey<FormState> flightFormKey = GlobalKey<FormState>();
  final origin = TextEditingController();
  final destination = TextEditingController();
  final departureDate = TextEditingController();
  final returnDate = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void flightPassengerBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: DeviceUtils.getScreenHeight(context) * 0.5,
            width: DeviceUtils.getScreenWidth(context),
            child: PassengerSelectionSheet(),
          );
        });
  }

  void flightClassBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: DeviceUtils.getScreenHeight(context) * 0.5,
            width: DeviceUtils.getScreenWidth(context),
            child: PassengerSelectionSheet(),
          );
        });
  }
}