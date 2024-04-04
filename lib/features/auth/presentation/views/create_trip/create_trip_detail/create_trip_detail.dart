import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_assistant/features/auth/domain/services/location_services.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/create_trip_detail/widgets/bottom_sheet_create.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/create_trip_detail/widgets/location_date_header.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/create_trip_detail/widgets/horizontal_calendar.dart';

import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../core/util/device/device_utility.dart';
import '../../../../../../core/util/formatters/formatter.dart';
import '../../../../../../core/util/helpers/helper_functions.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/button/text_icon_button.dart';

class CreateTripDetailView extends StatefulWidget {
  const CreateTripDetailView({super.key});

  @override
  State<CreateTripDetailView> createState() => _CreateTripDetailViewState();
}

class _CreateTripDetailViewState extends State<CreateTripDetailView> {
  DateTime? _selectedDate;
  String formattedDate = "";
  bool circular = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _setMarker(LatLng(37.42796133580664, -122.085749655962));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _handleDateChange(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      formattedDate = DateFormat('d, EEE').format(_selectedDate!);
    });
  }

  Future<void> _goToPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );

    _setMarker(LatLng(lat, lng));
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final rangeDatePickerValue = arguments?['rangeDatePickerValue'];
    final tripName = arguments?['tripName'];
    final location = arguments?['location'];

    DateTime? firstDate = rangeDatePickerValue[0];
    DateTime? lastDate = rangeDatePickerValue[1];
    String dateTitle =
        "${CustomFormatters.yearMonthDay.format(firstDate!)} - ${CustomFormatters.yearMonthDay.format(lastDate!)}";
    _selectedDate = firstDate;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        // Trip Name
        title: Text(
          tripName,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: CustomColors.primary),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _originController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(hintText: "Origin"),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        TextFormField(
                          controller: _destinationController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(hintText: "Search by City"),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var directions = await LocationServices().getDirections(
                        _originController.text,
                        _destinationController.text,
                      );
                      _goToPlace(directions['start_location']['lat'], directions['start_location']['lng'],);

                      _setPolyline(directions['polyline_decoded']);
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: _markers,
                  polylines: _polylines,
                  polygons: _polygons,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: (point) {
                    setState(() {
                      polygonLatLngs.add(point);
                      _setPolygon();
                    });
                  },
                ),
              ),
            ],
          ),
          // Draggable Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30.0)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: SpacingStyle.paddingWithNormalHeight,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 5,
                                color: CustomColors.grey,
                              ),
                            ),
                            // Location And Date
                            LocationAndDateHeader(
                                location: location, dateTitle: dateTitle),
                            const SizedBox(
                                height: CustomSizes.spaceBtwSections),

                            // Calendar
                            HorizontalCalendar(
                              selectedDate: _selectedDate!,
                              onDateChange: _handleDateChange,
                              initialDate: firstDate,
                            ),
                            const SizedBox(
                                height: CustomSizes.spaceBtwSections),

                            // Sign Up Button
                            TextIconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: CustomSizes.iconMd,
                              ),
                              buttonText: 'Add Location',
                              onPressed: () async {
                                _tripBottomSheet(context);
                              },
                            ),
                            const SizedBox(height: CustomSizes.spaceBtwItems),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Bottom sheet
  void _tripBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: DeviceUtils.getScreenHeight(context) * 0.5,
            width: DeviceUtils.getScreenWidth(context),
            child: const BottomSheetCreate(),
          );
        });
  }
}
