import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import 'location_model.dart';

class AttractionModel {
  String? tripId;
  String? attractionId;
  String attractionName;
  LocationModel? location;
  String description;
  String? image;
  Timestamp startTime;
  Timestamp endTime;
  int? order;

  AttractionModel({
    this.attractionId,
    required this.tripId,
    required this.attractionName,
    required this.location,
    required this.description,
    required this.image,
    required this.startTime,
    required this.endTime,
    this.order,
  });

  /// Static function to create an empty trip model.
  static AttractionModel empty() => AttractionModel(
        tripId: "",
        attractionName: "",
        location: null,
        description: '',
        image: '',
        startTime: Timestamp.fromDate(DateTime.now()),
        endTime: Timestamp.fromDate(DateTime.now()),
        order: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'TripId': tripId,
      'AttractionName': attractionName,
      'Location': location!.toJson(),
      'Description': description,
      'Image': image,
      'StartTime': startTime,
      'EndTime': endTime,
      'order': order,
    };
  }

  factory AttractionModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return AttractionModel(
        attractionId: document.id,
        tripId: data['TripId'] ?? '',
        attractionName: data['AttractionName'] ?? '',
        location: LocationModel.fromJson(data['Location']),
        description: data['Description'] ?? '',
        image: data['Image'] ?? '',
        startTime: data['StartTime'] ?? Timestamp.fromDate(DateTime(0)),
        endTime: data['EndTime'] ?? Timestamp.fromDate(DateTime(0)),
        order: data['order'] ?? 0,
      );
    }
    return AttractionModel.empty();
  }

  static Map<String, dynamic> _parseDateTime(String? dateTimeString) {
    if (dateTimeString != null && dateTimeString.isNotEmpty) {
      final dateTime = DateTime.parse(dateTimeString);
      return {
        'year': dateTime.year,
        'month': dateTime.month,
        'day': dateTime.day,
        'hour': dateTime.hour,
        'minute': dateTime.minute,
      };
    }
    return {};
  }
}
