import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../providers/modelprovider.dart';
import '../providers/themeprovider.dart';
import '../screens/doctors/doctorslist.dart';
import '../screens/memmographyscreening/memmography.dart';
import 'themetile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
            ),
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
              onTap: () {},
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
