import 'dart:convert';
import 'autocomplete_prediction.dart';

class PlaceAutoCompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;

  PlaceAutoCompleteResponse({this.status, this.predictions});

  factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteResponse(
        status: json['status'] as String?,
        predictions: json['predictions']?.map<AutocompletePrediction>(
            (json) => AutocompletePrediction.fromJson(json))
            .toList(),
    );
  }

  static PlaceAutoCompleteResponse parseAutoCompleteResult(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<String, dynamic>();

    return PlaceAutoCompleteResponse.fromJson(parsed);
  }
}

