import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../const/consts.dart';
import '../providers/languageprovider.dart';
import '../providers/reminderprovider.dart';

class ShowCalenderWidget {
  BuildContext context;
  DateTime? maxDate;
  bool enablePastDates;
  DateTime initialDisplayDate;
  DateTime initialSelectedDate;
  Function(Object?) onSubmit;
  ShowCalenderWidget({
    required this.context,
    required this.enablePastDates,
    this.maxDate,
    required this.initialDisplayDate,
    required this.initialSelectedDate,
    required this.onSubmit,
  }) {
    _showCalender();
  }
  // TODO: fix  localization for digits like dates and years
  _showCalender() {
    return showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          surfaceTintColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy',
                                context.read<LanguageProvider>().languageCode)
                            .format(
                                context.watch<ReminderProvider>().seletedDate),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateFormat('EEE, MMM dd',
                                context.read<LanguageProvider>().languageCode)
                            .format(
                                context.watch<ReminderProvider>().seletedDate),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SfDateRangePicker(
                  backgroundColor: Theme.of(context).primaryColor,
                  cancelText: AppLocalizations.of(context)!.cancelbutton,
                  confirmText: AppLocalizations.of(context)!.okbutton,
                  onSelectionChanged: (args) {
                    context.read<ReminderProvider>().seletedDate =
                        DateTime.parse(args.value.toString());
                  },
                  onSubmit: onSubmit,
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  selectionTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    todayTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  yearCellStyle: DateRangePickerYearCellStyle(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    todayTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  selectionColor: Theme.of(context).colorScheme.secondary,
                  todayHighlightColor: Colors.white,
                  showActionButtons: true,
                  enablePastDates: enablePastDates,
                  showNavigationArrow: true,
                  selectionMode: DateRangePickerSelectionMode.single,
                  view: DateRangePickerView.month,
                  maxDate: maxDate,
                  initialDisplayDate: initialDisplayDate,
                  initialSelectedDate: initialSelectedDate,
                  navigationDirection:
                      DateRangePickerNavigationDirection.vertical,
                  navigationMode: DateRangePickerNavigationMode.snap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
