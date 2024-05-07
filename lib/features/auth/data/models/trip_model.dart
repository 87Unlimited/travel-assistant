import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import 'location_model.dart';

class TripModel {
  final String userId;
  String? tripId;
  String tripName;
  LocationModel? location;
  String description;
  String? image;
  Timestamp? startDate;
  Timestamp? endDate;

  TripModel({
    this.tripId,
    required this.userId,
    required this.tripName,
    required this.location,
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
      description: '',
      image: '',
      startDate: null,
      endDate: null
  );

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'TripName': tripName,
      'Location': location!.toJson(),
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
        description: data['Description'] ?? '',
        image: data['Image'] ?? '',
        startDate: data['StartDate'] ?? '',
        endDate: data['EndDate'] ?? '',
      );
    }
    return TripModel.empty();
  }
}
