import 'dart:convert' as convert;
import 'dart:convert';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';

import '../../../../auth/secrets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FlightServices extends GetxController {
  static FlightServices get instance => Get.find();

  final String apiKey = amadeusApiKey;
  final String apiSecret = amadeusApiKeySecret;
  String _amadeusApiKeyToken = "dGQglXhv9d2BXXHDeNN0qww63S3B";

  Future<List<FlightModel>> fetchData(String origin, String destination, String departureDate, String returnDate, int adults, int child, int baby, String travelClass, bool nonStop) async {
    bool isEnded = false;
    String? accessToken = _amadeusApiKeyToken;

    while(!isEnded){
      var url = Uri.parse('https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode='
          '$origin&destinationLocationCode=$destination&departureDate=$departureDate&returnDate=$returnDate&adults=$adults&children=$child&infants=$baby&travelClass=$travelClass&nonStop=$nonStop&currencyCode=HKD&max=250');
      var headers = {'Authorization': 'Bearer $_amadeusApiKeyToken'};

      var response = await http.get(url, headers: headers);

      final jsonMap = json.decode(response.body);

      if (response.statusCode == 200) {
        // 請求成功，處理回應
        print(response.body);
        List<FlightModel> flightModels = jsonMap['data'].map<FlightModel>((data) {
          final airline = data['validatingAirlineCodes'][0];
          final flightNumber = data['itineraries'][0]['segments'][0]['number'];
          final departureAirport = data['itineraries'][0]['segments'][0]['departure']['iataCode'];
          final arrivalAirport = data['itineraries'][0]['segments'][0]['arrival']['iataCode'];
          final departureTime = DateTime.parse(data['itineraries'][0]['segments'][0]['departure']['at']);
          final arrivalTime = DateTime.parse(data['itineraries'][0]['segments'][0]['arrival']['at']);
          final order = int.parse(data['id']);

          // End the while loop
          isEnded = true;

          return FlightModel(
            airline: airline,
            flightNumber: flightNumber,
            departureAirport: departureAirport,
            arrivalAirport: arrivalAirport,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            order: order,
          );
        }).toList();

        // Return the list of FlightModel objects
        return flightModels;
      } if(response.statusCode == 401) {
        accessToken = await fetchAccessToken(); // Update accessToken value
        _amadeusApiKeyToken = accessToken!;
      } else {
        // 請求失敗，處理錯誤
        print('請求失敗: ${response.statusCode}');
        isEnded = true;
        return [];
      }
    }
    return [];
  }

  Future<String?> fetchAccessToken() async {
    var url = Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var body = {
      'grant_type': 'client_credentials',
      'client_id': amadeusApiKey,
      'client_secret': amadeusApiKeySecret,
    };

    var response = await http.post(url, headers: headers, body: body, encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200) {
      // 請求成功，處理回應
      print(response.body);
      var parsedJson = json.decode(response.body);
      var accessToken = parsedJson['access_token'];

      return accessToken;
    } else {
      // 請求失敗，處理錯誤
      print('請求失敗: ${response.statusCode}');
      return response.statusCode.toString();
    }
  }
}