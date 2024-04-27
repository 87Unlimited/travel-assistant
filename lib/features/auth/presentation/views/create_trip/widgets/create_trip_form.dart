import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/auth/secrets.dart';
import 'package:travel_assistant/core/network/network_utility.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';

import '../../../../../../common/widgets/search_bar/location_search_bar.dart';
import '../../../../../../common/widgets/section_heading.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../data/models/autocomplete_prediction.dart';
import '../../../../data/models/place_auto_complete_response.dart';
import '../../../../utilities/debounce.dart';
import 'location_list_tile.dart';

class CreateTripForm extends StatefulWidget {
  final TextEditingController tripName;
  final SearchController location;

  const CreateTripForm({Key? key, required this.tripName, required this.location}) : super(key: key);

  @override
  State<CreateTripForm> createState() => _CreateTripFormState();
}

class _CreateTripFormState extends State<CreateTripForm> {
  List<AutocompletePrediction> placePredictions = [];
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void placeAutoComplete(String query) async {
    _debouncer.run(() {
      Uri uri = Uri.https("maps.googleapis.com",
          'maps/api/place/autocomplete/json',
          {
            "input": query!,
            "key": placesApiKey,
            "types": "country",
          });

      NetworkUtility.fetchUrl(uri).then((String? response) {
        if (response != null) {
          PlaceAutoCompleteResponse result = PlaceAutoCompleteResponse
              .parseAutoCompleteResult(response);
          if (result.predictions != null) {
            setState(() {
              placePredictions = result.predictions!;
            });
            print(response);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Location Title
        const SectionHeading(title: "Country/Region", showActionButton: false,),
        const SizedBox(height: CustomSizes.spaceBtwItems),

        // Search Bar
        LocationSearchBar(
          controller: widget.location,
          leadingIcon: const Icon(Iconsax.location),
          trailingIcon: [
            IconButton(
              onPressed: () {print(widget.location.text);},
              icon: const Center(
                child: Icon(
                  CupertinoIcons.paperplane,
                ),
              ),
            )
          ],
          hintText: "Search Country/Region",
          viewOnChanged: (value) {
            if (value != "") {
              placeAutoComplete(value);
            } else {
              placePredictions.clear();
              setState(() {});
            }
          },
          suggestionsBuilder: (BuildContext context, SearchController location) {
            return Iterable<Widget>.generate(
                placePredictions.length, (int index) {
              return LocationListTile(
                location: placePredictions[index].description,
                press: () {
                  setState(() {
                    location.closeView(placePredictions[index].description!);
                    widget.location.text = placePredictions[index].description!;
                    print(widget.location.text);
                  });
                },
              );
            });
          },
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),

        // Trip Title
        const SectionHeading(title: "Trip Name", showActionButton: false,),
        const SizedBox(height: CustomSizes.spaceBtwItems),

        // Trip Form Field
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.location),
            labelText: "Trip Name",
          ),
          onChanged: (value) {
            placeAutoComplete(value);
          },
          controller: widget.tripName,
        ),
        const SizedBox(height: CustomSizes.spaceBtwItems),
      ],
    );
  }
}