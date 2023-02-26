import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../providers/reminderprovider.dart';
import '../../services/notificationservice.dart';
import 'reminder.dart';

class ReminderList extends StatelessWidget {
  const ReminderList({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Reminder',
        ),
      ),
      body: context.watch<ReminderProvider>().reminders.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SvgPicture.asset(
                    'assets/images/emptyreminder.svg',
                    semanticsLabel: 'Empty Reminder',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Flexible(
                  child: Text(
                    'No reminder Added Yet!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: context.watch<ReminderProvider>().reminders.length,
              itemBuilder: (context, index) {
                var reminder =
                    context.watch<ReminderProvider>().reminders[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const Reminder(),
                      //   ),
                      // );
                    },
                    child: Material(
                      color: Theme.of(context).primaryColor,
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
                                        DateFormat('EEE, dd MMMM yyyy')
                                            .format(reminder.reminderDateTime),
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
                                      DateFormat('h:mma')
                                          .format(reminder.reminderDateTime),
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
                    ),
                  ),
                );
              },
            ),
    );
  }
}
