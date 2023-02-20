import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../providers/modelprovider.dart';
import '../providers/themeprovider.dart';
import '../screens/doctors/doctorslist.dart';
import '../screens/memmographyscreening/memmography.dart';
import '../screens/reminder/reminderlist.dart';
import 'themetile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.65,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(
              height: 10,
            ),
            _buildListtile(
              iconData: LineIcons.stethoscope,
              tiletitle: 'Doctors',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorsList(),
                  ),
                );
              },
            ),
            _buildListtile(
              iconData: Icons.mobile_friendly,
              tiletitle: 'Delete Model',
              onTap: () {
                context.read<ModelProvider>().deleteModel();
              },
            ),
            _buildListtile(
              iconData: Icons.insights_outlined,
              tiletitle: 'Memmography Screening',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemmographyPrediction(),
                  ),
                );
              },
            ),
            _buildListtile(
              iconData: LineIcons.calendarAlt,
              tiletitle: 'Reminder',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReminderList(),
                  ),
                );
              },
            ),
            _buildListtile(
              tiletitle: 'Theme',
              iconData: context.watch<ThemeProvider>().themeMode ==
                      ThemeMode.system
                  ? Icons.phonelink_setup_outlined
                  : context.watch<ThemeProvider>().themeMode == ThemeMode.light
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
              onTap: () => showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const ThemeTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset('assets/logo.png'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Mr. Asraful Islam',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Emonats526@gmai.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Dhaka, Bangladesh',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildListtile({
    required IconData iconData,
    required String tiletitle,
    required Function onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: ListTile(
          title: Text(tiletitle),
          trailing: Icon(iconData),
        ),
      ),
    );
  }
}
