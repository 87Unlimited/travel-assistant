import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CreateTripDetailController extends GetxController {
  static CreateTripDetailController get instance => Get.find();

  // Variables
  final origin = SearchController();
  final destination = TextEditingController();
  final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();

  DateTime? selectedDate;
  String formattedDate = "";
  Set<Marker> markers = Set<Marker>();
  Set<Polygon> polygons = Set<Polygon>();
  Set<Polyline> polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int polygonIdCounter = 1;
  int polylineIdCounter = 1;

  @override
  void onInit() {
    super.onInit();
    setMarker(LatLng(37.42796133580664, -122.085749655962));
  }

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void setMarker(LatLng point) {
    markers.add(
      Marker(
        markerId: MarkerId('marker'),
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

  void handleDateChange(DateTime changedDate) {
    print(selectedDate);
    print(changedDate);
    selectedDate = changedDate;
    formattedDate = DateFormat('d, EEE').format(selectedDate!);
    print(" ");
    print(selectedDate);
    print(changedDate);
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

    setMarker(LatLng(lat, lng));
  }
}