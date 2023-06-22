import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../models/usermodel.dart';
import '../providers/authprovider.dart';
import '../screens/doctors/doctorslist.dart';
import '../screens/memmographyscreening/memmography.dart';
import '../screens/reminder/reminderlist.dart';
import '../screens/settings/settings.dart';
import '../utils/utils.dart';

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
            Consumer<AuthProvider>(
              builder: (context, value, child) {
                return StreamBuilder<UserModel?>(
                  stream: value.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData = snapshot.data!;

                      return _buildHeader(
                        context: context,
                        size: size,
                        name: "${userData.firstName} ${userData.lastName}",
                        age: Utils(context).calculateAge(
                          dateOfBirth: userData.dateofbirth,
                        ),
                        email: userData.email,
                        profilePhoto: userData.profilepicture,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return SpinKitDoubleBounce(
                        color: Theme.of(context).primaryColor,
                      );
                    }
                  },
                );
              },
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            _buildListtile(
              iconData: LineIcons.stethoscope,
              tiletitle: AppLocalizations.of(context)!.doctors,
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
              tiletitle: AppLocalizations.of(context)!.mammographyscreening,
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
              tiletitle: AppLocalizations.of(context)!.reminders,
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
              tiletitle: AppLocalizations.of(context)!.settings,
              iconData: Icons.settings_outlined,
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const SettingScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            _buildListtile(
              tiletitle: AppLocalizations.of(context)!.logoutbutton,
              iconData: Icons.logout,
              onTap: () async {
                await context.read<AuthProvider>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader({
    required BuildContext context,
    required Size size,
    required String name,
    required String age,
    required String email,
    required String profilePhoto,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.2,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: profilePhoto,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: size.height * 0.1,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: imageProvider,
                      height: size.height * 0.2,
                      width: size.height * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => SpinKitDoubleBounce(
                  color: Theme.of(context).primaryColor,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${AppLocalizations.of(context)!.name} : $name',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${AppLocalizations.of(context)!.email} : $email",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${AppLocalizations.of(context)!.age} : $age',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
