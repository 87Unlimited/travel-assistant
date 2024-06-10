import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_assistant/features/auth/data/models/activity_model.dart';

import '../../../../auth/secrets.dart';

class ActivitiesServices extends GetxController {
  static ActivitiesServices get instance => Get.find();

  final String apiKey = amadeusApiKey;
  final String apiSecret = amadeusApiKeySecret;
  String _amadeusApiKeyToken = "dGQglXhv9d2BXXHDeNN0qww63S3B";

  Future<List<ActivityModel>> fetchActivities(double lat, double lng) async{
    bool isEnded = false;
    String? accessToken = _amadeusApiKeyToken;

    // while(!isEnded){
    //   var url = Uri.parse('https://test.api.amadeus.com/v1/shopping/activities?latitude=$lat&longitude=$lng&radius=1');
    //
    //   var headers = {'Authorization': 'Bearer $_amadeusApiKeyToken'};
    //
    //   var response = await http.get(url, headers: headers);
    //
    //   final jsonMap = json.decode(response.body);
    //
    //   if (response.statusCode == 200) {
    //     // Request success, print result
    //     try{
    //       List<ActivityModel> activities = jsonMap['data'].map<ActivityModel>((data) {
    //         final id = data['id'];
    //         final name = data['name'];
    //         final description = data['description'];
    //         final latitude = data['geoCode']['latitude'];
    //         final longitude = data['geoCode']['longitude'];
    //         final rating = data['rating'];
    //         final price = data['price']['amount'];
    //         final picture = data['pictures'][0];
    //         final bookingLink = data['bookingLink'];
    //         final minimumDuration = data['minimumDuration'];
    //         final currencyCode = data['currencyCode'];
    //
    //         // End the while loop
    //         isEnded = true;
    //
    //         return ActivityModel(
    //           id: id,
    //           name: name == null ? "" : name,
    //           description: description == null ? "" : description,
    //           latitude: latitude,
    //           longitude: longitude,
    //           rating: rating == null ? 0.0 : double.parse(rating),
    //           price: price == null ? 0.0 : double.parse(price),
    //           picture: picture,
    //           bookingLink: bookingLink == null ? "" : bookingLink,
    //           minimumDuration: minimumDuration,
    //           currencyCode: currencyCode == null ? "" : currencyCode,
    //         );
    //       }).toList();
    //
    //       // Return the list of ActivityModel objects
    //       return activities;
    //     }catch(e){
    //       print(e.toString());
    //     }
    //   } if(response.statusCode == 401) {
    //     accessToken = await fetchAccessToken(); // Update accessToken value
    //     _amadeusApiKeyToken = accessToken!;
    //   } else {
    //     // Request failed
    //     print('Request failed: ${response.statusCode}');
    //     isEnded = true;
    //     return [];
    //   }
    // }
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
      // Request success
      print(response.body);
      var parsedJson = json.decode(response.body);
      var accessToken = parsedJson['access_token'];

      return accessToken;
    } else {
      // Request failed
      print('Request failed: ${response.statusCode}');
      return response.statusCode.toString();
    }
  }
}