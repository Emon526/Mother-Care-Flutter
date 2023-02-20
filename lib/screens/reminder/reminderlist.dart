import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../providers/reminderprovider.dart';
import '../../widget/drawer_widget.dart';
import 'reminder.dart';

class ReminderList extends StatelessWidget {
  const ReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Reminder(),
            ),
          );
        },
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Reminder',
        ),
      ),
      body: context.watch<ReminderProvider>().reminders.isEmpty
          ? const Center(
              child: Text('No reminder Added Yet!'),
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
                            Text(
                              reminder.reminderTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
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
                                      Text(
                                        reminder.reminderDate,
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
                                    Text(
                                      reminder.reminderTime,
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
