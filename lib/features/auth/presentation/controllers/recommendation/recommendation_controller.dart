import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/features/auth/data/models/activity_model.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../domain/services/activities_services.dart';
import '../../../domain/services/location_services.dart';
import '../flight/flight_controller.dart';

class RecommendationController extends GetxController {
  RecommendationController({this.trip});
  static RecommendationController get instance => Get.find();

  final flightController = Get.put(FlightController());
  final locationService = Get.put(LocationServices());
  final activitiesServices = Get.put(ActivitiesServices());

  RxBool isFlightsLoading = false.obs;
  RxBool isActivitiesLoading = false.obs;

  Rx<FlightModel> flight = FlightModel.empty().obs;
  RxList<ActivityModel> activities = <ActivityModel>[].obs;
  TripModel? trip;

  @override
  void onClose() {
    flightController.clearData();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    await getFlightRecommendation(trip!);
    super.onInit();
  }

  /// Flight Recommendation
  Future<void> getFlightRecommendation(TripModel trip) async {
    try {
      isFlightsLoading.value = true;

      // Get latlng of location
      Map<String, double> latlng = await locationService.getPlaceLatLng(trip.location!.locationId);

      // Start and end date
      String formattedStartDate = DateFormat('yyyy-MM-dd').format(trip.startDate!.toDate());
      String formattedEndDate = DateFormat('yyyy-MM-dd').format(trip.endDate!.toDate());

      // Get flight route result
      await flightController.fetchFlightRecommendationResult(
          latlng['latitude']!,
          latlng['longitude']!,
          "HKG",
          formattedStartDate,
          formattedEndDate
      );
      flight.value = flightController.flights[0];

      isFlightsLoading.value = false;
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Tours and activities Recommendation
  Future<void> getActivitiesRecommendation(TripModel trip) async {
    try {
      isActivitiesLoading.value = true;

      // Get latlng of location
      Map<String, double> latlng = await locationService.getPlaceLatLng(trip.location!.locationId);

      // Get flight route result
      List<ActivityModel> activity = await activitiesServices.fetchActivities(latlng['latitude']!, latlng['longitude']!);

      activities.assignAll(activity);

      isActivitiesLoading.value = false;
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}