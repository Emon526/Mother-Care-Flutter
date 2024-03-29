import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/reminderprovider.dart';
import '../../services/notificationservice.dart';
import '../../utils/utils.dart';
import '../../widget/emptywidget.dart';
import 'reminder.dart';

class ReminderList extends StatelessWidget {
  const ReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const Reminder(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.reminders,
        ),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () => context.read<ReminderProvider>().getPendingReminders(),
        child: context.watch<ReminderProvider>().reminders.isEmpty
            ? EmptyWidget(
                onRefresh: () {
                  return context.read<ReminderProvider>().getPendingReminders();
                },
                viewPadding: viewPadding,
                size: size,
                svgAsset: 'assets/images/schedule.svg',
                message: AppLocalizations.of(context)!.emptyReminder,
              )
            : ListView.builder(
                itemCount: context.watch<ReminderProvider>().reminders.length,
                itemBuilder: (context, index) {
                  var reminder =
                      context.watch<ReminderProvider>().reminders[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Consts.DefaultBorderRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  reminder.reminderTitle,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<ReminderProvider>()
                                      .deleteReminder(
                                        id: reminder.reminderId,
                                      );
                                  NotificationService()
                                      .deleteScheduleNotification(
                                    id: reminder.reminderId,
                                  );
                                },
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    const Icon(
                                      LineIcons.calendar,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      Utils(context).formatDate(
                                        dateTime: reminder.reminderDateTime,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    LineIcons.clock,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    Utils(context).formatTime(
                                      dateTime: reminder.reminderDateTime,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
