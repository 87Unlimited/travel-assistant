import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/common/widgets/custom_shapes/rounded_container.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/shadows.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/device/device_utility.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card_title_text.dart';

import '../../../../../../../../common/widgets/icons/text_with_icon.dart';
import '../../../../../../common/widgets/circular_icon_stack.dart';
import '../../../../../../core/util/formatters/formatter.dart';
import '../../trips/trips_view.dart';


class FlightCardRoundTrip extends StatelessWidget {
  const FlightCardRoundTrip({
    super.key,
    required this.flight,
  });

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    // Map<String, String> flightNumber = flight.flightNumber.map((key, value) => MapEntry(key, value!.toString()));
    String flightNumber = flight.flightNumber!['flightNumber'];
    String duration = flight.duration!['duration'];
    String departureAirport = flight.departureAirport!['departureAirport'];
    String arrivalAirport = flight.arrivalAirport!['arrivalAirport'];

    String returnFlightNumber = flight.flightNumber!['returnFlightNumber'];
    String returnDuration = flight.duration!['returnDuration'];
    String returnDepartureAirport = flight.departureAirport!['returnDepartureAirport'];
    String returnArrivalAirport = flight.arrivalAirport!['returnArrivalAirport'];

    // Four DateTime
    List<DateTime?> flightTimeList = CustomFormatters.convertTimestampListToDateTime([flight.departureTime, flight.arrivalTime, flight.returnDepartureTime, flight.returnArrivalTime]);

    String price = flight.price.toString();

    final departureTimeInDate = CustomFormatters.monthDateYear.format(flightTimeList[0]!);
    final departureTimeInTime = CustomFormatters.hourAndMinute.format(flightTimeList[0]!);
    final arrivalTimeInTime = CustomFormatters.hourAndMinute.format(flightTimeList[1]!);

    final returnDepartureTimeInDate = CustomFormatters.monthDateYear.format(flightTimeList[2]!);
    final returnDepartureTimeInTime = CustomFormatters.hourAndMinute.format(flightTimeList[2]!);
    final returnArrivalTimeInTime = CustomFormatters.hourAndMinute.format(flightTimeList[3]!);

    return SizedBox(
      width: DeviceUtils.getScreenWidth(context),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: DeviceUtils.getScreenWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(CustomSizes.cardRadiusLg),
                topRight: Radius.circular(CustomSizes.cardRadiusLg),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          departureTimeInDate,
                          style: Theme.of(context).textTheme.titleLarge!,
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),

                const SizedBox(height: CustomSizes.spaceBtwItems / 2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          departureTimeInTime,
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.secondary),
                        ),

                        TripCardTitleText(
                          title: departureAirport.toString(),
                          textStyle: Theme.of(context).textTheme.titleLarge!.apply(color: CustomColors.darkGrey),
                        ),
                      ],
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            flightNumber.toString(),
                            style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.darkGrey),
                          ),

                          Divider(
                            color: CustomColors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          Text(
                            duration.toString(),
                            style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.darkGrey),
                          ),
                        ],
                      ),
                    ),

                    // Arrival Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          arrivalTimeInTime,
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.secondary),
                        ),

                        TripCardTitleText(
                          title: arrivalAirport.toString(),
                          textStyle: Theme.of(context).textTheme.titleLarge!.apply(color: CustomColors.darkGrey),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: CustomSizes.spaceBtwItems),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          returnDepartureTimeInTime,
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.secondary),
                        ),

                        TripCardTitleText(
                          title: returnDepartureAirport,
                          textStyle: Theme.of(context).textTheme.titleLarge!.apply(color: CustomColors.darkGrey),
                        ),
                      ],
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            returnFlightNumber,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.darkGrey),
                          ),

                          Divider(
                            color: CustomColors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          Text(
                            returnDuration,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.darkGrey),
                          ),
                        ],
                      ),
                    ),

                    // Arrival Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          returnArrivalTimeInTime,
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.secondary),
                        ),

                        TripCardTitleText(
                          title: returnArrivalAirport,
                          textStyle: Theme.of(context).textTheme.titleLarge!.apply(color: CustomColors.darkGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: CustomColors.white,
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: CustomColors.whiteSmoke,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                    ),
                  ),
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                            (constraints.constrainWidth() / 15).floor(),
                            (index) => SizedBox(
                                  width: 5,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: CustomColors.secondary),
                                  ),
                                )),
                      );
                    },
                  ),
                )),
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: CustomColors.whiteSmoke,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(CustomSizes.cardRadiusLg),
                bottomLeft: Radius.circular(CustomSizes.cardRadiusLg),),
              color: CustomColors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'HK\$$price',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
                    ),
                    Spacer(),
                    CircularIconStack(
                      icon: Icons.add,
                      dark: false,
                      size: 40,
                      onTap: () => Get.to(TripView(flight: flight,)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}