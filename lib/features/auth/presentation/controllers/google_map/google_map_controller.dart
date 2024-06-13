import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../core/util/constants/colors.dart';
import '../../../domain/services/location_services.dart';

class CustomGoogleMapController extends GetxController {
  static CustomGoogleMapController get instance => Get.find();

  final origin = SearchController();
  final destination = TextEditingController();
  final locationServices = Get.put(LocationServices());
  Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();

  Set<Marker> markers = Set<Marker>();
  Set<Polygon> polygons = Set<Polygon>();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> routePoints = [];
  List<LatLng> polygonLatLngs = <LatLng>[];

  int polygonIdCounter = 1;
  int polylineIdCounter = 1;

  @override
  Future<void> onInit() async {
    await initializeMap();
    super.onInit();
  }

  @override
  void dispose() {
    googleMapController = Completer();
    super.dispose();
  }

  // void onMapCreated(GoogleMapController controller) {
  //   googleMapController = controller;
  // }

  Future<void> generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: CustomColors.secondary,
      points: polylineCoordinates,
      width: 5,
    );

    polylines[id] = polyline;
  }

  Future<void> initializeMap() async {
    LatLng origin = LatLng(22.302711, 114.177216);
    LatLng destination = LatLng(22.316668, 114.183334);
    final coordinates = await locationServices.fetchPolylinePoints(origin, destination);
    generatePolyLineFromPoints(coordinates);
  }

  // Future<void> calculateRoute(LatLng origin, LatLng destination) async {
  //   final GoogleMapController controller = await googleMapController.future;
  //
  //   List<LatLng> decodedPoints = getDecodedRoutePoints();
  //
  //   // 将坐标点添加到路线点列表中
  //   routePoints.addAll(decodedPoints);
  //
  //   // 在地图上绘制路线
  //   controller.addPolyline(
  //     Polyline(
  //       polylineId: PolylineId('route'),
  //       points: routePoints,
  //       color: Colors.blue,
  //       width: 3,
  //     ),
  //   );
  // }

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
      )
    );
    goToPlace(point);
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

  // void setPolyline(List<PointLatLng> points) {
  //   final String polylineIdVal = 'polyline_$polylineIdCounter';
  //   polylineIdCounter++;
  //
  //   polylines.add(
  //     Polyline(
  //       polylineId: PolylineId(polylineIdVal),
  //       width: 2,
  //       color: Colors.blue,
  //       points: points.map(
  //             (point) => LatLng(point.latitude, point.longitude),
  //           ).toList(),
  //     ),
  //   );
  // }

  Future<void> goToPlace(LatLng latlng) async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latlng,
          zoom: 17,
        ),
      ),
    );
    // setMarker(LatLng(lat, lng));
  }
}