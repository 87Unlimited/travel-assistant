import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/common/widgets/custom_shapes/rounded_container.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/shadows.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card_title_text.dart';

import '../../../../../../../../common/widgets/icons/text_with_icon.dart';
import '../../../../../../core/util/formatters/formatter.dart';


class FlightCard extends StatelessWidget {
  const FlightCard({
    super.key,
    required this.flight,
  });

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
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

    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
        color: Colors.white,
      ),
      child: RoundedContainer(
        height: 130,
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
                Text(
                  '\$ $price',
                  style: Theme.of(context).textTheme.titleLarge!,
                ),
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
          ],
        ),
      ),
    );
  }
}
