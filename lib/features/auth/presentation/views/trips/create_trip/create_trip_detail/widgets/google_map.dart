import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

import '../../../../../../domain/services/location_services.dart';
import '../../../../../controllers/google_map/google_map_controller.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomGoogleMapController());
    final tripController = Get.put(CreateTripDetailController());
    final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();

    String placeId = trip.location!.locationId;
    if(tripController.allAttractions.isNotEmpty) {
      placeId = tripController.allAttractions.last.location!.locationId;
    }

    return FutureBuilder<LatLng>(
      future: controller.setLatLng(placeId),
      builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          LatLng? initLatLng = snapshot.data;
          // controller.setLatLngAndMarker(placeId);
          if (initLatLng != null) {
            CameraPosition initialCamaraPosition = CameraPosition(
              target: initLatLng,
              zoom: 14,
            );

            return Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                markers: controller.markers,
                polylines: controller.polylines,
                polygons: controller.polygons,
                initialCameraPosition: initialCamaraPosition,
                onMapCreated: (GoogleMapController controller) {
                  googleMapController.complete(controller);
                },
                onTap: (point) {
                  controller.polygonLatLngs.add(point);
                  controller.setPolygon();
                },
              ),
            );
          } else {
            // 如果 initLatLng 為 null，可以顯示一個錯誤訊息或控制項
            return Text('Failed to get LatLng');
          }
        }
      },
    );
  }
}
