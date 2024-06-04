import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_assistant/core/util/formatters/formatter.dart';

class FlightModel {
  Map<String, dynamic>? flightNumber;
  Map<String, dynamic>? duration;
  Map<String, dynamic>? departureAirport;
  Map<String, dynamic>? arrivalAirport;
  Timestamp? departureTime;
  Timestamp? arrivalTime;
  Timestamp? returnDepartureTime;
  Timestamp? returnArrivalTime;
  double price;
  int? order;

  FlightModel({
    required this.flightNumber,
    required this.duration,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.returnDepartureTime,
    required this.returnArrivalTime,
    required this.price,
    this.order,
  });

  /// Static function to create an empty flight model.
  static FlightModel empty() => FlightModel(
    flightNumber: {},
    duration: {},
    departureAirport: {},
    arrivalAirport: {},
    departureTime: Timestamp.fromDate(DateTime.now()),
    arrivalTime: Timestamp.fromDate(DateTime.now()),
    returnDepartureTime: Timestamp.fromDate(DateTime.now()),
    returnArrivalTime: Timestamp.fromDate(DateTime.now()),
    price: 0.0,
    order: 0,
  );

  Map<String, dynamic> toJson() {
    return {
        'FlightNumber': flightNumber,
        'Duration': duration,
        'DepartureAirport': departureAirport,
        'ArrivalAirport': arrivalAirport,
        'DepartureTime': departureTime,
        'ArrivalTime': arrivalTime,
        'ReturnDepartureTime': returnDepartureTime,
        'ReturnArrivalTime': returnArrivalTime,
        'Price': price,
        'Order': order,
    };
  }

  factory FlightModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if(data.isEmpty) return FlightModel.empty();

    return FlightModel(
      price: data['Price'] ?? 0.0,
      flightNumber: data['FlightNumber'] as Map<String, dynamic>,
      duration: Map<String, dynamic>.from(data['Duration']),
      departureAirport: Map<String, dynamic>.from(data['DepartureAirport']),
      arrivalAirport: Map<String, dynamic>.from(data['ArrivalAirport']),
      departureTime: data['DepartureTime'] ?? Timestamp.fromDate(DateTime(0)),
      arrivalTime: data['ArrivalTime'] ?? Timestamp.fromDate(DateTime(0)),
      returnDepartureTime: data['ReturnDepartureTime'] ?? Timestamp.fromDate(DateTime(0)),
      returnArrivalTime: data['ReturnArrivalTime'] ?? Timestamp.fromDate(DateTime(0)),
      order: data['Order'],
    );
  }

  factory FlightModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FlightModel(
      flightNumber: Map<String, dynamic>.from(data['FlightNumber']),
      duration: Map<String, dynamic>.from(data['Duration']),
      departureAirport: Map<String, dynamic>.from(data['DepartureAirport']),
      arrivalAirport: Map<String, dynamic>.from(data['ArrivalAirport']),
      departureTime: data['DepartureTime'] ?? Timestamp.fromDate(DateTime(0)),
      arrivalTime: data['ArrivalTime'] ?? Timestamp.fromDate(DateTime(0)),
      returnDepartureTime: data['ReturnDepartureTime'] ?? Timestamp.fromDate(DateTime(0)),
      returnArrivalTime: data['ReturnArrivalTime'] ?? Timestamp.fromDate(DateTime(0)),
      price: data['Price'] ?? 0.0,
      order: data['Order'],
    );
  }
}