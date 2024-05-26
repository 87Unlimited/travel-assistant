import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../../../../../domain/services/location_services.dart';
import '../../../../../controllers/google_map/google_map_controller.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';


class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    super.key, required this.placeId,
  });

  final String placeId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomGoogleMapController());
    final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
    final locationServices = Get.put(LocationServices());

    return FutureBuilder<LatLng>(
      future: controller.setLatLng(placeId),
      builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 當仍在等待獲取 LatLng 值時，可以顯示一個等待指示器或其他控制項
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 如果發生錯誤，可以顯示錯誤訊息
          return Text('Error: ${snapshot.error}');
        } else {
          // 當成功獲取到 LatLng 值時，使用該值來設置 initialCamaraPosition
          LatLng? initLatLng = snapshot.data;

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
