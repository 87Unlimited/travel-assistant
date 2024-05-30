import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/services/location_services.dart';

class CustomGoogleMapController extends GetxController {
  static CustomGoogleMapController get instance => Get.find();

  final origin = SearchController();
  final destination = TextEditingController();
  final locationServices = Get.put(LocationServices());
  final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();

  Set<Marker> markers = Set<Marker>();
  Set<Polygon> polygons = Set<Polygon>();
  Set<Polyline> polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int polygonIdCounter = 1;
  int polylineIdCounter = 1;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setLatLngAndMarker(placeId) async {
    LatLng latLng = await setLatLng(placeId);
    setMarker(placeId, latLng);
  }

  Future<LatLng> setLatLng(placeId) async {
    Map<String, double> location = await locationServices.getPlaceLatLng(placeId);
    double? latitude = location['latitude'];
    double? longitude = location['longitude'];

    return LatLng(latitude!, longitude!);
  }

  void setMarker(String locationId, LatLng point) {
    markers.add(
      Marker(
        markerId: MarkerId(locationId),
        position: point,
      ),
    );
  }

  void setPolygon() {
    final String polygonIdVal = 'polygon_$polygonIdCounter';
    polygonIdCounter++;

    polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$polylineIdCounter';
    polylineIdCounter++;

    polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  Future<void> goToPlace(double lat, double lng) async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );

    // setMarker(LatLng(lat, lng));
  }
}