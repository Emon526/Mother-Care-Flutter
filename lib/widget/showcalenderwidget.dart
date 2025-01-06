import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const/consts.dart';
import '../providers/languageprovider.dart';

class ShowCalenderWidget {
  BuildContext context;
  bool enablePastDates;
  DateTime? initialDisplayDate;
  DateTime? initialSelectedDate;
  Function(Object?) onSubmit;
  ShowCalenderWidget({
    required this.context,
    required this.enablePastDates,
    this.initialDisplayDate,
    this.initialSelectedDate,
    required this.onSubmit,
  }) {
    _showCalender();
  }
  _showCalender() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // iOS Date Picker
      showCupertinoModalPopup<void>(
        context: context,
        barrierColor: Colors.black45, // Dimmed background
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Consts.DefaultBorderRadius)),
            ),
            child: CupertinoDatePicker(
              initialDateTime: initialDisplayDate ??
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
              minimumDate: enablePastDates
                  ? DateTime(
                      DateTime.now().year - 100,
                      DateTime.now().month,
                      DateTime.now().day,
                    )
                  : DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
              maximumDate: enablePastDates
                  ? DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    )
                  : DateTime(
                      DateTime.now().year + 100,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
              onDateTimeChanged: (DateTime newDate) {
                onSubmit(newDate);
              },
              mode: CupertinoDatePickerMode.date,
            ),
          );
        },
      );
    } else {
      // Android Date Picker
      showDatePicker(
        context: context,
        locale: Locale(context.read<LanguageProvider>().languageCode),
        initialDate: initialDisplayDate ?? DateTime.now(),
        firstDate: enablePastDates
            ? DateTime(
                DateTime.now().year - 100,
                DateTime.now().month,
                DateTime.now().day,
              )
            : DateTime.now(),
        lastDate: enablePastDates
            ? DateTime.now()
            : DateTime(DateTime.now().year + 100),
        // selectableDayPredicate: (day) {
        //   // log(day.toString());
        //   return day != initialDisplayDate;
        //   // return enablePastDates;
        // },
      ).then((selectedDate) {
        if (selectedDate != null) {
          onSubmit(selectedDate);
          // onSubmit;
        }
      });
    }
  }

  // _showSFCalender() {
  //   return showCupertinoModalPopup<void>(
  //     context: context,
  //     // barrierDismissible: false,
  //     barrierColor: Colors.black45,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
  //         ),
  //         insetPadding: EdgeInsets.symmetric(
  //           horizontal: MediaQuery.of(context).size.width * 0.05,
  //         ),
  //         backgroundColor: Theme.of(context).primaryColor,
  //         surfaceTintColor: Colors.transparent,
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       DateFormat('yyyy',
  //                               context.read<LanguageProvider>().languageCode)
  //                           .format(
  //                               context.watch<ReminderProvider>().seletedDate),
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(
  //                       DateFormat('EEE, MMM dd',
  //                               context.read<LanguageProvider>().languageCode)
  //                           .format(
  //                               context.watch<ReminderProvider>().seletedDate),
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 30,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               SfDateRangePicker(
  //                 backgroundColor: Theme.of(context).primaryColor,
  //                 cancelText: AppLocalizations.of(context)!.cancelbutton,
  //                 confirmText: AppLocalizations.of(context)!.okbutton,
  //                 onSelectionChanged: (args) {
  //                   context.read<ReminderProvider>().seletedDate =
  //                       DateTime.parse(args.value.toString());
  //                 },
  //                 onSubmit: onSubmit,
  //                 onCancel: () {
  //                   Navigator.pop(context);
  //                 },
  //                 monthViewSettings: const DateRangePickerMonthViewSettings(
  //                   viewHeaderStyle: DateRangePickerViewHeaderStyle(
  //                     textStyle: TextStyle(
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //                 headerStyle: DateRangePickerHeaderStyle(
  //                   textStyle: const TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                   backgroundColor: Theme.of(context).primaryColor,
  //                 ),
  //                 selectionTextStyle: TextStyle(
  //                   color: Theme.of(context).primaryColor,
  //                 ),
  //                 monthCellStyle: const DateRangePickerMonthCellStyle(
  //                   todayTextStyle: TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                   textStyle: TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 yearCellStyle: DateRangePickerYearCellStyle(
  //                   textStyle: const TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                   todayTextStyle: TextStyle(
  //                     color: Theme.of(context).colorScheme.secondary,
  //                   ),
  //                 ),
  //                 selectionColor: Theme.of(context).colorScheme.secondary,
  //                 todayHighlightColor: Colors.white,
  //                 showActionButtons: true,
  //                 enablePastDates: enablePastDates,
  //                 showNavigationArrow: true,
  //                 selectionMode: DateRangePickerSelectionMode.single,
  //                 view: DateRangePickerView.month,
  //                 maxDate: maxDate,
  //                 initialDisplayDate: initialDisplayDate,
  //                 initialSelectedDate: initialSelectedDate,
  //                 navigationDirection:
  //                     DateRangePickerNavigationDirection.vertical,
  //                 navigationMode: DateRangePickerNavigationMode.snap,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
