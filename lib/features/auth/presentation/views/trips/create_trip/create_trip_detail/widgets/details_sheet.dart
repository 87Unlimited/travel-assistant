import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/recommend_list.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/schedule_list.dart';

import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../../core/util/formatters/formatter.dart';
import '../../../../../../data/models/trip_model.dart';
import '../../../../../controllers/trips/attraction_controller.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';
import 'location_date_header.dart';

class DetailsSheet extends StatelessWidget {
  const DetailsSheet({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripDetailController());
    final attractionsController = Get.put(AttractionController());
    final createTripDetailController = Get.put(CreateTripDetailController());
    createTripDetailController.trip = trip;
    createTripDetailController.getMarker();

    DateTime? firstDate = trip.startDate!.toDate();
    DateTime? lastDate = trip.endDate!.toDate();
    String dateTitle =
        "${CustomFormatters.yearMonthDay.format(firstDate)} - ${CustomFormatters.yearMonthDay.format(lastDate)}";
    controller.selectedDate = firstDate;

    createTripDetailController.tripId = trip.tripId!;

    StepperType _type = StepperType.vertical;

    List<String> tabs = [
      "Schedule",
      "Recommendation"
    ];

    Rx<int> current = 0.obs;

    double changePositionedOfLine() {
      switch (current.value) {
        case 0:
          return 0;
        case 1:
          return 90;
        default:
          return 0;
      }
    }

    double changeContainerWidth() {
      switch (current.value) {
        case 0:
          return 70;
        case 1:
          return 130;
        default:
          return 50;
      }
    }

    // Bottom sheet
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
          child: Container(
            decoration: const BoxDecoration(
              color: CustomColors.whiteSmoke,
            ),
            child: ListView(
              controller: scrollController,
              children: [
                Padding(
                  padding: SpacingStyle.paddingWithNormalHeight,
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 5,
                          color: CustomColors.grey,
                        ),
                      ),
                      // Location And Date
                      LocationAndDateHeader(
                          location: trip.location!.locationName,
                          dateTitle: dateTitle),
                      const SizedBox(height: CustomSizes.spaceBtwSections),

                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tabs.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Obx(() => GestureDetector(
                                            onTap: (){
                                              current.value = index;
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: index == 0 ? 10 : 22,
                                                top: 7,
                                              ),
                                              child: Text(
                                                tabs[index],
                                                style: current == index ? Theme.of(context).textTheme.titleLarge!.apply(color: CustomColors.secondary)
                                                : Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Obx(() => AnimatedPositioned(
                                    bottom: 0,
                                    left: changePositionedOfLine(),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration: const Duration(microseconds: 500,),
                                    child: AnimatedContainer(
                                      duration: Duration(microseconds: 500,),
                                      margin: const EdgeInsets.only(left: 10),
                                      width: changeContainerWidth(),
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: CustomColors.secondary,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Obx(() => Padding(
                              padding: EdgeInsets.only(top: 20,),
                              child: current.value == 0 ? RecommendList() :
                              ScheduleList(firstDate: firstDate, trip: trip),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: CustomSizes.spaceBtwSections),

                      // Calendar

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}