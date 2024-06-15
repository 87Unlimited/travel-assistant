import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/formatters/formatter.dart';
import '../../../../../../data/models/trip_model.dart';
import '../../../../../controllers/google_map/google_map_controller.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';
import 'horizontal_calendar.dart';
import 'location_card.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({
    super.key,
    required this.firstDate,
    required this.trip,
    required this.tripController,
  });

  final DateTime? firstDate;
  final TripModel trip;
  final CreateTripDetailController tripController;

  @override
  Widget build(BuildContext context) {
    final mapController = Get.find<CustomGoogleMapController>();
    return Column(
      children: [
        HorizontalCalendar(
          selectedDate: tripController.selectedDate!,
          onDateChange: tripController.handleDateChange,
          initialDate: firstDate,
        ),
        const SizedBox(height: CustomSizes.spaceBtwSections),

        // TripStepper(),
        SizedBox(
          height: 400,
          child: Obx(() {
            if (tripController.attractionsOfSingleDay.isEmpty) {
              return Text("You have no activities yet.");
            } else {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: tripController.attractionsOfSingleDay
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
                            onPressed: (_) async {
                              tripController.deleteAttraction(tripController.attractionsOfSingleDay[index].attractionId);
                              await mapController.getMarker();
                              await mapController.fetchPolylinePoints(mapController.markers);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.3,
                        isFirst: tripController.attractionsOfSingleDay[index] == tripController.attractionsOfSingleDay.first ? true : false,
                        isLast: tripController.attractionsOfSingleDay[index] == tripController.attractionsOfSingleDay.last ? true : false,
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          color: CustomColors.secondary,
                          padding: const EdgeInsets.only(left: 4, right: 8),
                          iconStyle: IconStyle(
                            color: Colors.white,
                            iconData: Icons.directions_car,
                            fontSize: 30,
                          ),
                        ),

                        startChild: Container(
                          width: 30,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                CustomFormatters.hourAndMinute.format(
                                    tripController.attractionsOfSingleDay[index].startTime.toDate()
                                ),
                                  style: Theme.of(context).textTheme.titleLarge!.apply(color: Colors.blueGrey),
                                ),
                                Icon(Icons.remove, color: Colors.blueGrey,),
                                Text(
                                  CustomFormatters.hourAndMinute.format(
                                      tripController.attractionsOfSingleDay[index].endTime.toDate()
                                  ),
                                  style: Theme.of(context).textTheme.titleLarge!.apply(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        endChild: LocationCard(
                          attraction: tripController.attractionsOfSingleDay[index],
                          controller: tripController,
                        ),
                      )
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
            tripController.tripBottomSheet(context, trip);
          },
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),
      ],
    );
  }
}
