import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../core/util/constants/colors.dart';

class HorizontalCalendar extends StatefulWidget {
  final Function(DateTime) onDateChange;
  final DateTime? selectedDate;
  final DateTime? initialDate;

  const HorizontalCalendar({
    super.key,
    required this.onDateChange,
    required this.selectedDate,
    required this.initialDate,
  });

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime? _focusDate;
  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    _focusDate = DateTime.now();
    formattedDate = DateFormat('d, EEE').format(_focusDate!);
  }

  void _selectDate(DateTime selectedDate) {
    widget.onDateChange(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: widget.initialDate!,
      onDateChange: (selectedDate) {
        _selectDate(selectedDate);
      },
      activeColor: CustomColors.secondary,
      headerProps: EasyHeaderProps(
        dateFormatter: const DateFormatter.fullDateDayAsStrMY(),
        monthPickerType: MonthPickerType.switcher,
        showSelectedDate: true,
        monthStyle: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.primary),
        selectedDateStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.primary),
      ),
      dayProps: const EasyDayProps(
        height: 56.0,
        width: 56.0,
        dayStructure: DayStructure.dayNumDayStr,
        inactiveDayStyle: DayStyle(
          borderRadius: 48.0,
          dayNumStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        activeDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
