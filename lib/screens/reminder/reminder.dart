import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';

import '../../const/consts.dart';
import '../../models/remindermodel.dart';
import '../../providers/reminderprovider.dart';
import '../../services/notificationservice.dart';
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
          title: const Text(
            'Add Reminder',
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
                        return 'Please Enter Title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Menstrual Self Check',
                      border: OutlineInputBorder(),
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
                              return 'Pick a Date';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            hintText: 'Date',
                            border: OutlineInputBorder(),
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
                              return 'Pick a Time';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            hintText: 'Time',
                            border: OutlineInputBorder(),
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
                        DateTime reminderDate =
                            DateFormat('E, dd MMMM yyyy h:mma').parse(
                          '${dateController.text} ${timeController.text}',
                        );
                        context.read<ReminderProvider>().addReminder(
                              reminder: ReminderModel(
                                reminderId: id,
                                reminderTitle: titleController.text.trim(),
                                reminderDateTime: reminderDate,
                              ),
                            );

                        NotificationService().showScheduleNotification(
                          id: id,
                          title: titleController.text.trim(),
                          body: 'Reminder ID : $id',
                          scheduleDateTime: reminderDate,
                          payload: '$reminderDate',
                        );

                        ResponsiveSnackbar.show(
                          context,
                          'You will be reminded in ${context.read<ReminderProvider>().getDuration(reminderDate)}',
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Reminder'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _showClock() {
    return showPicker(
      dialogInsetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      borderRadius: Consts.DefaultBorderRadius,
      okText: 'OK',
      cancelText: 'CANCEL',
      iosStylePicker: true,
      context: context,
      barrierDismissible: false,
      okStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      cancelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      value: context.read<ReminderProvider>().time,
      onChange: (newTime) {
        context.read<ReminderProvider>().time = newTime;
      },
      minuteInterval: MinuteInterval.ONE,
      // Optional onChange to receive value as DateTime
      onChangeDateTime: (DateTime dateTime) {
        // print(dateTime);
        // debugPrint("[debug datetime]:  $dateTime");
        timeController.text = DateFormat("h:mma").format(dateTime);
      },
    );
  }

  _showCalender() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy').format(
                            context.watch<ReminderProvider>().seletedDate),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormat('EEE, MMM dd').format(
                            context.watch<ReminderProvider>().seletedDate),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SfDateRangePicker(
                  onSelectionChanged: (args) {
                    context.read<ReminderProvider>().seletedDate =
                        DateTime.parse(args.value.toString());
                  },
                  onSubmit: (date) {
                    dateController.text = DateFormat('EEE, dd MMMM yyyy')
                        .format(DateTime.parse(date.toString()));
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  // selectionTextStyle: TextStyle(
                  //   color: Colors.red,
                  // ),

                  // viewSpacing: 100,
                  // headerStyle: DateRangePickerHeaderStyle(
                  //   backgroundColor: Colors.red,
                  // ),

                  selectionColor: Theme.of(context).primaryColor,
                  todayHighlightColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
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
}
