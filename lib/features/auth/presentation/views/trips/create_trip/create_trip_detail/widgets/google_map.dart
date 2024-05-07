import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../../../../controllers/google_map/google_map_controller.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';


class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomGoogleMapController());
    final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();

    return Expanded(
      child: GoogleMap(
        mapType: MapType.normal,
        markers: controller.markers,
        polylines: controller.polylines,
        polygons: controller.polygons,
        initialCameraPosition: controller.kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        },
        onTap: (point) {
          controller.polygonLatLngs.add(point);
          controller.setPolygon();
        },
      ),
    );
  }
}
