import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../calendar_config.dart';

class RangeDatePicker extends StatelessWidget {
  const RangeDatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<DateTime?> _dates = [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
          config: CalendarConfig.getConfig(),
          value: _dates,
          onValueChanged: (dates) => _dates = dates,
        ),
      ],
    );
  }
}