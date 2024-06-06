import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';

import 'location_model.dart';

class TripModel {
  final String userId;
  String? tripId;
  String tripName;
  LocationModel? location;
  FlightModel? flight;
  String description;
  String? image;
  Timestamp? startDate;
  Timestamp? endDate;

  TripModel({
    this.tripId,
    required this.userId,
    required this.tripName,
    required this.location,
    this.flight,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
  });

  /// Static function to create an empty trip model.
  static TripModel empty() => TripModel(
      userId: "",
      tripName: "",
      location: null,
      flight: null,
      description: '',
      image: '',
      startDate: null,
      endDate: null
  );

  Map<String, dynamic> toJson() {
    final flightJson = flight != null ? flight!.toJson(false) : FlightModel.empty().toJson(false);
    return {
      'UserId': userId,
      'TripName': tripName,
      'Location': location!.toJson(),
      'Flight': flightJson,
      'Description': description,
      'Image': image,
      'StartDate': startDate,
      'EndDate': endDate,
    };
  }

  factory TripModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return TripModel(
        tripId: document.id,
        userId: data['UserId'] ?? '',
        tripName: data['TripName'] ?? '',
        location: LocationModel.fromJson(data['Location']),
        flight: FlightModel.fromJson(data['Flight'] as Map<String, dynamic>),
        description: data['Description'] ?? '',
        image: data['Image'] ?? '',
        startDate: data['StartDate'] ?? '',
        endDate: data['EndDate'] ?? '',
      );
    }
    return TripModel.empty();
  }
}
