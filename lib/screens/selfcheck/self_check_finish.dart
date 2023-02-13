import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SelfCheckFinish extends StatelessWidget {
  const SelfCheckFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'DID YOU NOTICE ANYTHING UNUSUAL?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Keep calm - most changes are not dangerous.\n\nCheck again after your next menstrual cycle. If it\'s still there, consult your doctor or health professional.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Set a Reminder'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  LineIcons.calendarAlt,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Consult Doctor'),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  LineIcons.stethoscope,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
