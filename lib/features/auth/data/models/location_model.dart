class LocationModel {
  String locationId;
  String locationName;

  LocationModel({
    required this.locationId,
    required this.locationName,
  });

  static LocationModel empty() => LocationModel(locationId: "", locationName: "");

  toJson() {
    return {
      'LocationId': locationId,
      'LocationName': locationName,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return LocationModel.empty();

    return LocationModel(
      locationId: data['LocationId'] ?? '',
      locationName: data['LocationName'] ?? '',
    );
  }

  String getLocationId() {
    return locationId;
  }
}
