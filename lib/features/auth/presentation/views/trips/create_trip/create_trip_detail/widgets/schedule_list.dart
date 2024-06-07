import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../data/models/trip_model.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';
import 'horizontal_calendar.dart';
import 'location_card.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({
    super.key,
    required this.firstDate,
    required this.trip,
  });

  final DateTime? firstDate;
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripDetailController());
    final createTripDetailController = Get.put(CreateTripDetailController());

    return Column(
      children: [
        HorizontalCalendar(
          selectedDate: controller.selectedDate!,
          onDateChange: controller.handleDateChange,
          initialDate: firstDate,
        ),
        const SizedBox(height: CustomSizes.spaceBtwSections),

        // TripStepper(),
        SizedBox(
          height: 200,
          child: Obx(() {
            if (createTripDetailController.attractionsOfSingleDay.isEmpty) {
              return Text("You have no activities yet.");
            } else {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: createTripDetailController.attractionsOfSingleDay
                    .length,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) =>
                const SizedBox(height: CustomSizes.spaceBtwItems),
                itemBuilder: (context, index) =>
                    Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 1,
                            onPressed: (_) =>
                                createTripDetailController.deleteAttraction(
                                    createTripDetailController
                                        .attractionsOfSingleDay[index]
                                        .attractionId),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: LocationCard(
                        attraction: createTripDetailController
                            .attractionsOfSingleDay[index], delete: () {},
                      ),
                    ),
              );
            }
          }),
        ),
        const SizedBox(height: CustomSizes.spaceBtwSections),

        // Add Location Button
        TextIconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: CustomSizes.iconMd,
          ),
          buttonText: 'Add Location',
          onPressed: () async {
            controller.tripBottomSheet(context, trip);
          },
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),
      ],
    );
  }
}
