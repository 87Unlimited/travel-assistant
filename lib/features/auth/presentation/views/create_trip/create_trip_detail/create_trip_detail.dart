import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/create_trip_detail/widgets/bottom_sheet_create.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/create_trip_detail/widgets/horizontal_calendar.dart';
import 'package:travel_assistant/features/auth/presentation/views/create_trip/create_trip_detail/widgets/trip_detail_form.dart';

import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../core/util/device/device_utility.dart';
import '../../../../../../core/util/formatters/formatter.dart';
import '../../../../../../core/util/helpers/helper_functions.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/section_heading.dart';

class CreateTripDetailView extends StatefulWidget {
  const CreateTripDetailView({super.key});

  @override
  State<CreateTripDetailView> createState() => _CreateTripDetailViewState();
}

class _CreateTripDetailViewState extends State<CreateTripDetailView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _rePassword;
  late final TextEditingController _fullName;
  late final TextEditingController _phone;

  DateTime? _selectedDate;
  String formattedDate = "";
  bool circular = false;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    _rePassword = TextEditingController();
    _fullName = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    _rePassword.dispose();
    _fullName.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _handleDateChange(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      formattedDate = DateFormat('d, EEE').format(_selectedDate!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    List<DateTime?> dateRange = Get.arguments;
    DateTime? firstDate = dateRange[0];
    _selectedDate = firstDate;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Trip Detail",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: CustomColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithNormalHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar
              HorizontalCalendar(
                selectedDate: _selectedDate!,
                onDateChange: _handleDateChange,
                initialDate: firstDate,
              ),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Selected date
              Text(
                CustomFormatters.dayAndWeek.format(_selectedDate!),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),

              // Trip Details
              // TripDetailForm(email: _email, password: _password, fullName: _fullName, phone: _phone),
              const SizedBox(height: CustomSizes.spaceBtwSections),

              // Sign Up Button
              Center(
                child: SizedBox(
                  width: CustomSizes.buttonWidth,
                  height: CustomSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () async {
                      _tripBottomSheet(context);
                    },
                    child: const Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: CustomSizes.iconMd,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Add Location'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: CustomSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom sheet
  void _tripBottomSheet(context) {
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return SizedBox(
        height: DeviceUtils.getScreenHeight(context) * 0.5,
        width: DeviceUtils.getScreenWidth(context),
        child: const BottomSheetCreate(),
      );
    });
  }
}