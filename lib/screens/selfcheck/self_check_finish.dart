import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../doctors/doctorslist.dart';
import '../reminder/reminder.dart';

class SelfCheckFinish extends StatelessWidget {
  const SelfCheckFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Keep calm - most changes are not dangerous.\n\nCheck again after your next menstrual cycle. If it\'s still there, consult your doctor or health professional.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const Reminder(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  // PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  //   context,
                  //   settings: const RouteSettings(name: RouteManager.reminder),
                  //   screen: const Reminder(),
                  //   withNavBar: false,
                  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  // );

                  // PersistentNavBarNavigator.pushDynamicScreen(
                  //   context,
                  //   screen: MaterialPageRoute(builder: builder),
                  //   withNavBar: true,
                  // );
                },
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
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const DoctorsList(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
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
          )
        ],
      ),
    ));
  }
}
