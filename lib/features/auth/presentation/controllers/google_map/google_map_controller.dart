import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../auth/secrets.dart';
import '../../../../../core/util/constants/colors.dart';
import '../../../data/models/attraction_model.dart';
import '../../../domain/services/location_services.dart';
import '../trips/create_trip_detail_controller.dart';

class CustomGoogleMapController extends GetxController {
  static CustomGoogleMapController get instance => Get.find();

  // Api key
  final String? key = placesApiKey;
  // Controllers
  final origin = SearchController();
  final destination = TextEditingController();
  final locationServices = Get.put(LocationServices());
  final createTripDetailController = Get.find<CreateTripDetailController>();
  final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
  // Variables
  List<Marker> markers = <Marker>[].obs;
  // Set<Marker> markers = Set<Marker>();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  List<LatLng> routePoints = [];
  List<LatLng> polygonLatLngs = <LatLng>[];

  @override
  Future<void> onInit() async {
    await initializeMap();
    super.onInit();
  }

  @override
  void dispose() {
    clearData();
    super.dispose();
  }

  void clearData() {
    // googleMapController = Completer();
    markers.clear();
    polylines.clear();
    routePoints.clear();
    polygonLatLngs.clear();
    update();
  }

  // void onMapCreated(GoogleMapController controller) {
  //   googleMapController = controller;
  // }

  Future<void> initializeMap() async {
    clearData();
    await getMarker();
    await fetchPolylinePoints(markers);
  }

  Future<void> fetchPolylinePoints(List<Marker> markers) async {
    List<LatLng> polylineCoordinates = [];

    for (var i = 0; i < markers.length - 1; i++) {
      final String apiKey = key!;
      final String origin = '${markers[i].position.latitude},${markers[i].position.longitude}';
      final String destination = '${markers[i + 1].position.latitude},${markers[i + 1].position.longitude}';
      final String url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=driving&key=$apiKey';

      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final List<dynamic> routes = data['routes'];
        final Map<String, dynamic> route = routes[0];
        final List<dynamic> legs = route['legs'];
        final Map<String, dynamic> leg = legs[0];
        final List<dynamic> steps = leg['steps'];

        for (final step in steps) {
          final String polyline = step['polyline']['points'];
          final List<LatLng> decodedPolyline = decodePolyline(polyline);
          polylineCoordinates.addAll(decodedPolyline);
        }
      } else {
        print('Error: ${data['status']}');
      }
    }

    generatePolyLineFromPoints(polylineCoordinates);
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1E5;
      double longitude = lng / 1E5;
      LatLng point = LatLng(latitude, longitude);
      polyline.add(point);
    }

    return polyline;
  }

  Future<void> generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: CustomColors.secondary,
      points: polylineCoordinates,
      width: 5,
    );

    polylines[id] = polyline;
    print(polylines);
  }

  Future<LatLng> setLatLng(placeId) async {
    Map<String, double> location = await locationServices.getPlaceLatLng(placeId);
    double? latitude = location['latitude'];
    double? longitude = location['longitude'];

    return LatLng(latitude!, longitude!);
  }

  Future<void> getMarker({VoidCallback? onAttractionsChange}) async {
    List<AttractionModel> allAttractions = createTripDetailController.allAttractions;

    if (onAttractionsChange != null) {
      // Call the provided callback function when allAttractions change
      createTripDetailController.onAttractionsChange = onAttractionsChange;
    }

    for (var index = 0; index < allAttractions.length; index++) {
      var attraction = allAttractions[index];
      // LatLng of the location
      LatLng locationLatLng = await setLatLng(attraction.location!.locationId);
      // Set marker using the LatLng
      setMarker(attraction.location!.locationId, locationLatLng, index);
      // Set camera to the last attraction point
      if (index == allAttractions.length + 1) {
        await goToPlace(locationLatLng);
      }
    }
  }

  void setMarker(String locationId, LatLng point, int index) {
    markers.add(
      Marker(
        markerId: MarkerId(locationId),
        position: point,
        infoWindow: InfoWindow(
          title: 'Order: $index',
        ),
      ),
    );
    //goToPlace(point);
  }

  Future<void> goToPlace(LatLng latlng) async {
    try{
      final GoogleMapController controller = await googleMapController.future;
      Timer(Duration(milliseconds: 500), () async {
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: latlng,
              zoom: 17,
            ),
          ),
        );
      });
    } catch (e){
      print(e.toString());
    }
    // setMarker(LatLng(lat, lng));
  }
}