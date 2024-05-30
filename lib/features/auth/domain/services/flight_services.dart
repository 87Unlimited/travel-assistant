import '../../../../auth/secrets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FlightServices extends GetxController {
  static FlightServices get instance => Get.find();

  final String? key = amadeusApiKeyToken;

  void fetchData(String origin, String destination) async {
    var url = Uri.parse('https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode='
        '$origin&destinationLocationCode=$destination&departureDate=2024-06-04&adults=1&nonStop=false&max=250');
    var headers = {'Authorization': 'Bearer $amadeusApiKeyToken'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // 請求成功，處理回應
      print(response.body);
    } else {
      // 請求失敗，處理錯誤
      print('請求失敗: ${response.statusCode}');
    }
  }
}