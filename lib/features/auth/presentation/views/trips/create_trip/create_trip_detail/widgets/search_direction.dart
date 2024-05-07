import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../domain/services/location_services.dart';
import '../../../../../controllers/google_map/google_map_controller.dart';

class SearchDirection extends StatelessWidget {
  const SearchDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomGoogleMapController());

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              TextFormField(
                controller: controller.origin,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: "Origin"),
                onChanged: (value) {
                  print(value);
                },
              ),
              TextFormField(
                controller: controller.destination,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: "Search by City"),
                onChanged: (value) {
                  print(value);
                },
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            var directions = await LocationServices().getDirections(
              controller.origin.text.trim(),
              controller.destination.text.trim(),
            );
            controller.goToPlace(directions['start_location']['lat'], directions['start_location']['lng'],);

            controller.setPolyline(directions['polyline_decoded']);
          },
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}