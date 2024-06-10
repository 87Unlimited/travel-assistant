import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/recommendation/recommendation_controller.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/trips/trip_controller.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../core/util/popups/full_screen_loader.dart';
import '../../data/models/trip_model.dart';
import '../../data/repositories/trip/trip_repository.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;
  final tripRepository = Get.put(TripRepository());
  final tripController = Get.put(TripController());
  final recommendationController = Get.put(RecommendationController());
  final activityPictures = <String>[].obs;
  RxList<TripModel> homeViewTrips = <TripModel>[].obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  @override
  void onInit() {
    fetchHomeViewTrips();
    fetchRecommendActivities();
    super.onInit();
  }

  /// Get the trips of user
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

  /// Get recommendation activities based on user's latest trip
  void fetchRecommendActivities() async {
    try {
      // Fetch trips
      await recommendationController.getActivitiesRecommendation(tripController.upcomingTrips[0]);

      for(var activity in recommendationController.activities){
        if (activityPictures.length < 5) {
          activityPictures.add(activity.picture.toString());
        } else {
          break;
        }
      }
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}