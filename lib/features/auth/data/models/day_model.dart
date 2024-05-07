import 'package:cloud_firestore/cloud_firestore.dart';

class DayModel {
  String? dayId;
  String? tripId;
  Timestamp? date;

  DayModel({
    this.dayId,
    required this.tripId,
    required this.date,
  });

  /// Static function to create an empty trip model.
  static DayModel empty() => DayModel(
      tripId: "",
      date: null,
  );

  Map<String, dynamic> toJson() {
    return {
      'TripId': tripId,
      'Date': date,
    };
  }

  factory DayModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DayModel(
        dayId: document.id,
        tripId: data['TripId'] ?? '',
        date: data['Date'] ?? '',
      );
    }
    return DayModel.empty();
  }
}
