class ActivityModel {
  ActivityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.rating,
    required this.price,
    required this.picture,
    required this.bookingLink,
    required this.minimumDuration,
    required this.currencyCode,
  });

  String id;
  String name;
  String description;
  double latitude;
  double longitude;
  double? rating;
  double price;
  String picture;
  String bookingLink;
  String minimumDuration;
  String currencyCode;

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'Rating': rating,
      'Latitude': latitude,
      'Longitude': longitude,
      'Price': price,
      'Picture': picture,
      'BookingLink': bookingLink,
      'MinimumDuration': minimumDuration,
      'CurrencyCode': currencyCode,
    };
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
      rating: json['Rating'] ?? 0.0,
      latitude: json['Latitude'] ?? 0.0,
      longitude: json['Longitude'] ?? 0.0,
      price: json['Price'] ?? 0.0,
      picture: json['Picture'] ?? '',
      bookingLink: json['BookingLink'] ?? '',
      minimumDuration: json['MinimumDuration'] ?? '',
      currencyCode: json['CurrencyCode'] ?? '',
    );
  }

  /// Static function to create an empty airport model.
  static ActivityModel empty() => ActivityModel(
    id: '',
    name: '',
    description: '',
    latitude: 0.0,
    longitude: 0.0,
    rating: 0.0,
    price: 0.0,
    picture: '',
    bookingLink: '',
    minimumDuration: '',
    currencyCode: '',
  );
}