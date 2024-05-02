import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/widgets/create_trip_form.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/widgets/range_date_picker.dart';

import '../../../../../../common/widgets/appbar.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../navigation_menu.dart';
import 'calendar_config.dart';
import 'create_trip_detail/create_trip_detail.dart';

class CreateTripView extends StatefulWidget {
  const CreateTripView({super.key});

  @override
  State<CreateTripView> createState() => _CreateTripViewState();
}

class _CreateTripViewState extends State<CreateTripView> {
  late final TextEditingController _tripName;
  late final SearchController _location;

  final today = DateUtils.dateOnly(DateTime.now());
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [];
  final _config = CalendarConfig.getConfig();

  @override
  void initState() {
    // TODO: implement initState
    _tripName = TextEditingController();
    _location = SearchController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tripName.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final config = CalendarConfig.getConfig();
    final navController = Get.put(NavigationController());

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: false,
        leadingIcon: Iconsax.arrow_left,
        leadingOnPressed: () => navController.screens[2],
        title: Text(
          "Create Itinerary",
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              CreateTripForm(),
              const SizedBox(height: CustomSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
