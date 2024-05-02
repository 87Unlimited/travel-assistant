import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../core/util/popups/full_screen_loader.dart';
import '../../data/models/trip_model.dart';
import '../../data/repositories/trip/trip_repository.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;
  final tripRepository = Get.put(TripRepository());
  RxList<TripModel> homeViewTrips = <TripModel>[].obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  @override
  void onInit() {
    fetchHomeViewTrips();
    super.onInit();
  }

  void fetchHomeViewTrips() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "We are processing your information...",
          "assets/animations/loading.json");

      // Fetch trips
      final trips = await tripRepository.getHomeViewTrips();

      // Assign trips
      homeViewTrips.assignAll(trips);
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      // Remove Loader
      FullScreenLoader.stopLoading();
    }
  }
}