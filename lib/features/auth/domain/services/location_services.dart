import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';

import '../../../../auth/secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/network/network_utility.dart';
import '../../data/models/autocomplete_prediction.dart';
import '../../data/models/place_auto_complete_response.dart';
import '../../utilities/debounce.dart';

class LocationServices extends GetxController{
  static LocationServices get instance => Get.find();

  final String? key = placesApiKey;

  List<AutocompletePrediction> placePredictions = <AutocompletePrediction>[].obs;
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  void placeAutoComplete(String query, String type) async {
    _debouncer.run(() {
      Uri uri = Uri.https("maps.googleapis.com",
          'maps/api/place/autocomplete/json',
          {
            "input": query!,
            "key": placesApiKey,
            "types": type,
          });

      NetworkUtility.fetchUrl(uri).then((String? response) {
        if (response != null) {
          PlaceAutoCompleteResponse result = PlaceAutoCompleteResponse
              .parseAutoCompleteResult(response);
          if (result.predictions != null) {
            placePredictions = result.predictions!;
            print(response);
          }
        }
      });
    });
  }

  void placeAutoCompleteWithCountryRestrict(String query, String type, String country) async {
    _debouncer.run(() {
      Uri uri = Uri.https("maps.googleapis.com",
          'maps/api/place/autocomplete/json',
          {
            "input": query!,
            "key": placesApiKey,
            "types": type,
            "components": "country:${country}",
          });

      NetworkUtility.fetchUrl(uri).then((String? response) {
        if (response != null) {
          PlaceAutoCompleteResponse result = PlaceAutoCompleteResponse
              .parseAutoCompleteResult(response);
          if (result.predictions != null) {
            placePredictions = result.predictions!;
            print(response);
          }
        }
      });
    });
  }

  Future<String> getPlaceId(String input) async {
    final String url = ""
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key";

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    print(placeId);
    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String placeId) async {
    // final placeId = await getPlaceId(input);

    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;
  }

  Future<String> getPlaceNameById(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var formatted_address = json['result']['formatted_address'];
    return formatted_address;
  }

  Future<Map<String, double>> getPlaceLatLng(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

      final lat = data['result']['geometry']['location']['lat'];
      final lng = data['result']['geometry']['location']['lng'];

      return {
        'latitude': double.parse(lat.toString()),
        'longitude': double.parse(lng.toString()),
      };
    } else {
      throw Exception('Failed to fetch location details');
    }
  }

  Future<String> getPlaceByLatLng(double lat, double lng) async {
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

      if (data['results'] != null && data['results'].isNotEmpty) {
        List<dynamic> addressComponents = data['results'][0]['address_components'];
        String country = "";
        String locality = "";

        // Find result contain country and locality
        for (var component in addressComponents) {
          List<dynamic> types = component['types'];
          if (types.contains('country')) {
            country = component['long_name'];
          } else if(types.contains('locality')){
            locality = component['long_name'];
          }
        }
        // Combine country and locality
        final address = locality + ", " + country;
        return address;
      }
      return "";
    } else {
      throw Exception('Failed to fetch location details');
    }
  }

  Future<String> getPlacePhotoReference(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final photoReference = data['result']['photos'][0]['photo_reference'];
      return photoReference;
    } else {
      throw Exception('Failed to fetch location details');
    }
  }

  Future<String> getPlacePhoto(String photoReference) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/photo?maxheight=300&maxwidth=300&photoreference=$photoReference&key=$key";
    print(url);

    return url;
  }

  Future<String> getCountryAbbreviationByPlaceId(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var addressComponents = json['result']['address_components'];

    for (var component in addressComponents) {
      var types = component['types'];
      if (types.contains('country')) {
        var abbreviation = component['short_name'];
        print(abbreviation);
        return abbreviation;
      }
    }

    return '';
  }

  Future<String?> getIATACodeFromLocation(String placeId) async {
    final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

      if (data['status'] == 'OK') {
        final iataCode = data['result']['address_components']
            .firstWhere((component) => component['types'].contains('airport'))
        ['short_name'];
        return iataCode;
      }
    }
    return null; // 如果找不到對應的IATA碼，返回null或其他適當值
  }

  Future<Map<String, dynamic>> getDirections(String origin, String destination) async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key";

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var result = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded' : PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    print(response);
    return result;
  }
}