class AirportModel {
  String iataCode;
  String cityName;
  String countryName;
  String countryCode;

  AirportModel({
    required this.iataCode,
    required this.cityName,
    required this.countryName,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'IataCode': iataCode,
      'CityName': cityName,
      'CountryName': countryName,
      'CountryCode': countryCode,
    };
  }

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      iataCode: json['IataCode'] ?? '',
      cityName: json['CityName'] ?? '',
      countryName: json['CountryName'] ?? '',
      countryCode: json['CountryCode'] ?? '',
    );
  }

  /// Static function to create an empty airport model.
  static AirportModel empty() => AirportModel(
    iataCode: '',
    cityName: '',
    countryName: '',
    countryCode: '',
  );
}