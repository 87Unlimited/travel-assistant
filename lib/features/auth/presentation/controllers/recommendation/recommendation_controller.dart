import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../domain/services/location_services.dart';
import '../flight/flight_controller.dart';

class RecommendationController extends GetxController {
  RecommendationController({required this.trip});
  static RecommendationController get instance => Get.find();

  final flightController = Get.put(FlightController());
  final locationService = Get.put(LocationServices());

  RxBool isLoading = false.obs;

  Rx<FlightModel> flight = FlightModel.empty().obs;
  TripModel trip;

  @override
  void onClose() {
    flightController.clearData();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    await getFlightRecommendation(trip);
    super.onInit();
  }

  Future<void> getFlightRecommendation(TripModel trip) async {
    try {
      isLoading.value = true;

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

      isLoading.value = false;
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}