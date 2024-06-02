import 'package:cloud_firestore/cloud_firestore.dart';

class FlightModel {
  String? flightId;
  Map<String, dynamic> flightNumber;
  Map<String, dynamic> duration;
  Map<String, dynamic> departureAirport;
  Map<String, dynamic> arrivalAirport;
  Map<DateTime, dynamic> departureTime;
  Map<DateTime, dynamic> arrivalTime;
  double price;
  int? order;

  FlightModel({
    this.flightId,
    required this.flightNumber,
    required this.duration,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    this.order,
  });

  /// Static function to create an empty flight model.
  static FlightModel empty() => FlightModel(
    flightNumber: {},
    duration: {},
    departureAirport: {},
    arrivalAirport: {},
    departureTime: {},
    arrivalTime: {},
    price: 0.0,
    order: 0,
  );

  Map<String, dynamic> toJson() {
    return {
      'flightId': flightId,
      'flightNumber': flightNumber,
      'duration': duration,
      'departureAirport': departureAirport,
      'arrivalAirport': arrivalAirport,
      'departureTime': {departureTime.keys.first.toIso8601String(), departureTime.keys.last.toIso8601String()},
      'arrivalTime': {arrivalTime.keys.first.toIso8601String(), arrivalTime.keys.last.toIso8601String()},
      'price': price,
      'order': order,
    };
  }

  factory FlightModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return FlightModel(
        flightId: document.id,
        flightNumber: data['flightNumber'] ?? {},
        duration: {},
        departureAirport: data['departureAirport'] ?? {},
        arrivalAirport: data['arrivalAirport'] ?? {},
        departureTime: {DateTime.parse(data['departureTime']): {}},
        arrivalTime: {DateTime.parse(data['arrivalTime']): {}},
        price: data['price'] ?? 0.0,
        order: data['order'] ?? 0,
      );
    }
    return FlightModel.empty();
  }
}