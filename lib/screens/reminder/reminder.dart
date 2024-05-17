import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/remindermodel.dart';
import '../../providers/languageprovider.dart';
import '../../providers/reminderprovider.dart';
import '../../services/notificationservice.dart';
import '../../utils/utils.dart';
import '../../widget/showcalenderwidget.dart';
import '../../widget/showclockwidget.dart';

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
  //TODO:: check is notification permission is granted or not.if needed use separate page to naviagte system settings
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
                          onTap: () => ShowCalenderWidget(
                            context: context,
                            enablePastDates: false,
                            initialDisplayDate: DateTime.now(),
                            initialSelectedDate: DateTime.now(),
                            onSubmit: (date) {
                              dateController.text = Utils(context).formatDate(
                                dateTime: DateTime.parse(
                                  date.toString(),
                                ),
                              );
                              Navigator.pop(context);
                            },
                          ),
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
                          onTap: () => ShowClockWidget(
                            context: context,
                            controller: timeController,
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
                    onPressed: () async {
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
                        Navigator.pop(context);
                        await showsnackbar(
                          reminderDate: reminderDate,
                        );

                        await showsNotification(
                          id: id,
                          reminderDate: reminderDate,
                        );
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

  Future<void> showsnackbar({
    required DateTime reminderDate,
  }) async {
    await Utils(context).showsnackbar(
      message: AppLocalizations.of(context)!.addReminderSnakeBar(
        context.read<ReminderProvider>().getDuration(
            context: context,
            reminderDate: reminderDate,
            local: context.read<LanguageProvider>().languageCode),
      ),
    );
  }

  Future<void> showsNotification({
    required int id,
    required DateTime reminderDate,
  }) async {
    await NotificationService().showScheduleNotification(
      id: id,
      title: AppLocalizations.of(context)!.reminders,
      body: titleController.text.trim(),
      scheduleDateTime: reminderDate,
      payload: '$reminderDate',
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
