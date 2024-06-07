import 'package:flutter/material.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/flight/widgets/flight_card_roundtrip.dart';

class RecommendList extends StatelessWidget {
  const RecommendList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SectionHeading(title: "Flights", textColor: CustomColors.primary, showActionButton: false,),
          // FlightCardRoundTrip(flight: FlightModel.empty()),
        ],
      ),
    );
  }
}