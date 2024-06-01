import 'package:cloud_firestore/cloud_firestore.dart';

class FlightModel {
  String? flightId;
  String airline;
  String flightNumber;
  String departureAirport;
  String arrivalAirport;
  DateTime departureTime;
  DateTime arrivalTime;
  int order;

  FlightModel({
    this.flightId,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.order,
  });

  /// Static function to create an empty flight model.
  static FlightModel empty() => FlightModel(
    airline: "",
    flightNumber: "",
    departureAirport: "",
    arrivalAirport: "",
    departureTime: DateTime.now(),
    arrivalTime: DateTime.now(),
    order: 0,
  );

  Map<String, dynamic> toJson() {
    return {
      'Airline': airline,
      'FlightNumber': flightNumber,
      'DepartureAirport': departureAirport,
      'ArrivalAirport': arrivalAirport,
      'DepartureTime': departureTime.toIso8601String(),
      'ArrivalTime': arrivalTime.toIso8601String(),
      'Order': order,
    };
  }

  factory FlightModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return FlightModel(
        flightId: document.id,
        airline: data['Airline'] ?? '',
        flightNumber: data['FlightNumber'] ?? '',
        departureAirport: data['DepartureAirport'] ?? '',
        arrivalAirport: data['ArrivalAirport'] ?? '',
        departureTime: DateTime.parse(data['DepartureTime']),
        arrivalTime: DateTime.parse(data['ArrivalTime']),
        order: data['Order'] ?? 0,
      );
    }
    return FlightModel.empty();
  }
}