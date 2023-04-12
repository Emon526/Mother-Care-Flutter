import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../const/consts.dart';
import '../providers/nav_bar_provider.dart';
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
            _buildHeader(context: context),
            const SizedBox(
              height: 10,
            ),
            _buildListtile(
              iconData: LineIcons.stethoscope,
              tiletitle: 'Doctors',
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const DoctorsList(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            // _buildListtile(
            //   iconData: Icons.mobile_friendly,
            //   tiletitle: 'Delete Model',
            //   onTap: () {
            //     context.read<ModelProvider>().deleteModel();
            //   },
            // ),
            _buildListtile(
              iconData: Icons.insights_outlined,
              tiletitle: 'Memmography Screening',
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const MemmographyPrediction(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            _buildListtile(
              iconData: LineIcons.calendarAlt,
              tiletitle: 'Reminder',
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const ReminderList(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
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
            // _buildListtile(
            //   iconData: LineIcons.envelope,
            //   tiletitle: 'Contact Us',
            //   onTap: () {},
            // ),
            _buildListtile(
              iconData: LineIcons.code,
              tiletitle: 'Credits',
              onTap: () => _credits(context),
            ),
            _buildListtile(
              iconData: LineIcons.infoCircle,
              tiletitle: 'About ${Consts.APP_NAME}',
              onTap: () => _about(context),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader({required BuildContext context}) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: const [
        //       Text(
        //         'Mr. Asraful Islam',
        //         style: TextStyle(
        //           fontSize: 16,
        //           color: Colors.white,
        //         ),
        //       ),
        //       SizedBox(
        //         height: 5,
        //       ),
        //       Text(
        //         'Emonats526@gmai.com',
        //         style: TextStyle(
        //           fontSize: 14,
        //           color: Colors.white,
        //         ),
        //       ),
        //       SizedBox(
        //         height: 5,
        //       ),
        //       Text(
        //         'Dhaka, Bangladesh',
        //         style: TextStyle(
        //           fontSize: 14,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Future<void> _credits(
    BuildContext context,
  ) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  'This project has been submitted in partial fulfilment of the requirements for the Bachelor of Science in Computer Science and Engineering degree.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Submitted By',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _submittedBy(
                name: 'Asraful Islam',
                id: '191-15-12515',
              ),
              const SizedBox(
                height: 10,
              ),
              _submittedBy(
                name: 'MD Shahajada Hasib',
                id: '191-15-12812',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'And',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _submittedBy(
                name: 'Sabbir Hossain Riad',
                id: '191-15-12135',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _about(
    BuildContext context,
  ) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  Consts.APP_NAME,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                // 'Version no ${}',
                context.watch<NavBarProvider>().appVersion,
                style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'You are using latest version of this application ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          ),
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

  _submittedBy({
    required String name,
    required String id,
  }) {
    return Column(
      children: [
        Text(name),
        Text(id),
        const Text('Department of CSE'),
        const Text('Daffodil International University'),
      ],
    );
  }
}
