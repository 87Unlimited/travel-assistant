// class DirectionResponse{
//   final List<LatLng> route;
//
//   DirectionResponse({required this.route});
//
//   factory DirectionResponse.fromJson(Map<String, dynamic> json) {
//     final polylinePoints = json['routes'][0]['polyline']['encodedPolyline'];
//     return DirectionResponse(route: decodePoly)
//   }
// }