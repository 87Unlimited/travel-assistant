import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/widgets/create_trip_form.dart';

import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../navigation_menu.dart';
import '../../widgets/appbar.dart';
import '../../widgets/section_heading.dart';
import '../home/widgets/home_appbar.dart';
import 'calendar_config.dart';
import 'create_trip_detail/create_trip_detail.dart';

class CreateTripView extends StatefulWidget {
  const CreateTripView({super.key});

  @override
  State<CreateTripView> createState() => _CreateTripViewState();
}

class _CreateTripViewState extends State<CreateTripView> {
  late final TextEditingController _tripName;
  late final TextEditingController _location;

  final today = DateUtils.dateOnly(DateTime.now());
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [];
  final _config = CalendarConfig.getConfig();

  @override
  void initState() {
    // TODO: implement initState
    _tripName = TextEditingController();
    _location = TextEditingController();
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
    final controller = Get.find<NavigationController>();
    final dark = HelperFunctions.isDarkMode(context);
    final config = CalendarConfig.getConfig();

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
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
              _buildDefaultRangeDatePickerWithValue(config),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Selection(s):  '),
                  const SizedBox(width: 10),
                  Text(
                    _getValueText(
                      config.calendarType,
                      _rangeDatePickerValueWithDefaultValue,
                    ),
                  ),
                ],
              ),
              // Create Trip Form
              Form(
                child: CreateTripForm(
                  tripNameController: _tripName,
                  locationController: _location,
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              Center(
                child: SizedBox(
                  width: CustomSizes.buttonWidth,
                  height: CustomSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.to(const CreateTripDetailView(), arguments: _rangeDatePickerValueWithDefaultValue);
                    },
                    child: const Center(
                      child: Text('Create Trip'),
                    ),
                  ),
                ),
              ),
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

  Widget _buildDefaultRangeDatePickerWithValue(CalendarDatePicker2Config config) {
    final config = _config;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        ),
      ],
    );
  }
}
