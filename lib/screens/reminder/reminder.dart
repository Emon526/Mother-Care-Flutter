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
                        context.read<ReminderProvider>().addReminder(
                              reminder: ReminderModel(
                                reminderTitle: titleController.text.trim(),
                                reminderDate: dateController.text.trim(),
                                reminderTime: timeController.text.trim(),
                              ),
                            );
                        NotificationService().showScheduleNotification(
                          title: titleController.text.trim(),
                          body: 'It\'s works',
                          scheduleDateTime:
                              DateFormat('E, dd MMMM yyyy h:mma').parse(
                            '${dateController.text} ${timeController.text}',
                          ),
                        );
                        ResponsiveSnackbar.show(
                          context,
                          'Reminder Added',
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
      okText: 'OK',
      cancelText: 'CANCEL',
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
      minuteInterval: MinuteInterval.ONE,
      // Optional onChange to receive value as DateTime
      onChangeDateTime: (DateTime dateTime) {
        // print(dateTime);
        debugPrint("[debug datetime]:  $dateTime");
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: SfDateRangePicker(
                  onSubmit: (date) {
                    var formattedDate = DateFormat('EEE, dd MMMM yyyy')
                        .format(DateTime.parse(date.toString()));
                    debugPrint(formattedDate.toString());
                    dateController.text = formattedDate;
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  selectionColor: Theme.of(context).primaryColor,
                  todayHighlightColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  showActionButtons: true,
                  enablePastDates: false,
                  selectionMode: DateRangePickerSelectionMode.single,
                  view: DateRangePickerView.month,
                  initialDisplayDate: DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
