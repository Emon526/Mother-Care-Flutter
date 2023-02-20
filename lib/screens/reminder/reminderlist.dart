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
      drawer: const DrawerWidget(),
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
                    child: ListTile(
                      title: Text(
                        reminder.reminderTitle,
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(LineIcons.clock),
                          Text(
                              '${reminder.reminderDate},${reminder.reminderTime}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
