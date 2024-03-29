import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

import '../../const/consts.dart';
import '../../models/remindermodel.dart';
import '../../providers/languageprovider.dart';
import '../../providers/reminderprovider.dart';
import '../../services/notificationservice.dart';
import '../../utils/utils.dart';
import '../../widget/responsivesnackbar.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final _reminderformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.addReminder,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _reminderformKey,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .addRemindertitleError;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.addReminderTitle,
                      hintText: AppLocalizations.of(context)!.addReminderHint,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          onTap: () => _showCalender(),
                          readOnly: true,
                          controller: dateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .addReminderDateError;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.addReminderDate,
                            hintText:
                                AppLocalizations.of(context)!.addReminderDate,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          onTap: () => Navigator.of(context).push(
                            _showClock(),
                          ),
                          controller: timeController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .addReminderTimeError;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.addReminderTime,
                            hintText:
                                AppLocalizations.of(context)!.addReminderTime,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_reminderformKey.currentState!.validate()) {
                        int id =
                            context.read<ReminderProvider>().reminders.length;
                        DateTime reminderDate = _getReminderDate();

                        context.read<ReminderProvider>().addReminder(
                              reminder: ReminderModel(
                                reminderId: id,
                                reminderTitle: titleController.text.trim(),
                                reminderDateTime: reminderDate,
                              ),
                            );

                        NotificationService().showScheduleNotification(
                          id: id,
                          title: AppLocalizations.of(context)!.reminders,
                          body: titleController.text.trim(),
                          scheduleDateTime: reminderDate,
                          payload: '$reminderDate',
                        );

                        ResponsiveSnackbar.show(
                          context,
                          AppLocalizations.of(context)!.addReminderSnakeBar(
                            context.read<ReminderProvider>().getDuration(
                                context: context,
                                reminderDate: reminderDate,
                                local: context
                                    .read<LanguageProvider>()
                                    .languageCode),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.addReminder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

//TODO: fix background color for day-night-time-picker in dark mode
  //TODO: fix day-night-time-picker localization for am,pm,hour,min and digits
  _showClock() {
    return showPicker(
      // accentColor: Colors.red,
      // barrierColor: Colors.black,
      dialogInsetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      height: 390,
      borderRadius: Consts.DefaultBorderRadius,
      okText: AppLocalizations.of(context)!.okbutton,
      cancelText: AppLocalizations.of(context)!.cancelbutton,
      // hourLabel: 'hour',
      // minuteLabel: 'min',
      iosStylePicker: true,
      context: context,
      barrierDismissible: false,
      okStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      cancelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      value: context.read<ReminderProvider>().time,
      onChange: (newTime) {
        context.read<ReminderProvider>().time = newTime;
      },
      minuteInterval: TimePickerInterval.ONE,

      onChangeDateTime: (DateTime dateTime) {
        timeController.text = Utils(context).formatTime(
          dateTime: dateTime,
        );
      },
    );
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
                  onSubmit: (date) {
                    dateController.text = Utils(context).formatDate(
                      dateTime: DateTime.parse(
                        date.toString(),
                      ),
                    );
                    Navigator.pop(context);
                  },
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
                  enablePastDates: false,
                  showNavigationArrow: true,
                  selectionMode: DateRangePickerSelectionMode.single,
                  view: DateRangePickerView.month,
                  initialDisplayDate: DateTime.now(),
                  initialSelectedDate: DateTime.now(),
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

  DateTime _getReminderDate() {
    String date = dateController.text;
    String time = timeController.text
        .replaceAll('এ.এম.', 'AM')
        .replaceAll('পি.এম.', 'PM');
    DateFormat dateformat = DateFormat(
        'E, dd MMMM yyyy h:mma', context.read<LanguageProvider>().languageCode);
    DateTime reminderDate = dateformat.parse('$date $time');
    return reminderDate;
  }
}
